import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weath_app/common/errors/exceptions.dart';
import 'package:weath_app/common/errors/failures.dart';
import 'package:weath_app/common/network/connection/network_info.dart';
import 'package:weath_app/features/home_screen/data/data_sources/home_remote_data_source.dart';
import 'package:weath_app/features/home_screen/data/model/weather_model.dart';
import 'package:weath_app/features/home_screen/domain/repositories/home_repository.dart';

import '../../../../fixtures/fixture_weather_model.dart';

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late final ProviderContainer container;
  late final HomeRemoteDataSource homeRemoteDataSource;

  setUpAll(() {
    container = ProviderContainer(
      overrides: [
        homeRemoteDataSourceProvider
            .overrideWith((ref) => MockHomeRemoteDataSource()),
        networkInfoProvider.overrideWith((ref) => MockNetworkInfo()),
      ],
    );
    homeRemoteDataSource = container.read(homeRemoteDataSourceProvider);
  });

  group('network available before the request', () {
    test('should get weather data with city successfully', () async {
      const requestCity = 'cairo';
      when(() => container.read(networkInfoProvider).isConnected)
          .thenAnswer((_) async => true);
      Future<WeatherModel> repoFunction() => container
          .read(homeRemoteDataSourceProvider)
          .getWeatherData(city: requestCity);
      when(repoFunction).thenAnswer((_) async => testWeatherModel);

      final result = await container
          .read(homeRepositoryProvider)
          .getWeatherData(city: requestCity);
      expect(result, testWeatherModel);
      verify(repoFunction);
      verify(() => container.read(networkInfoProvider).isConnected);
      verifyNoMoreInteractions(homeRemoteDataSource);
      verifyNoMoreInteractions(container.read(networkInfoProvider));
    });

    test('should get weather data with lat and long successfully', () async {
      const lat = 30.05;
      const long = 31.25;
      when(() => container.read(networkInfoProvider).isConnected)
          .thenAnswer((_) async => true);
      Future<WeatherModel> repoFunction() => container
          .read(homeRemoteDataSourceProvider)
          .getWeatherData(lat: lat, long: long);

      when(() => container.read(homeRemoteDataSourceProvider).getWeatherData(
          lat: lat, long: long)).thenAnswer((_) async => testWeatherModel);

      final result = await container
          .read(homeRepositoryProvider)
          .getWeatherData(lat: lat, long: long);
      expect(result, testWeatherModel);
      verify(repoFunction);
      verify(() => container.read(networkInfoProvider).isConnected);
      verifyNoMoreInteractions(homeRemoteDataSource);
      verifyNoMoreInteractions(container.read(networkInfoProvider));
    });
    test('should throw server error if no data sent in the request', () async {
      when(() => container.read(networkInfoProvider).isConnected)
          .thenAnswer((_) async => true);
      Future<WeatherModel> repoFunction() =>
          container.read(homeRemoteDataSourceProvider).getWeatherData();

      when(repoFunction).thenThrow(const ServerException(message: ''));

      expect(container.read(homeRepositoryProvider).getWeatherData(),
          throwsA(isA<ServerFailure>()));
      verify(() => container.read(networkInfoProvider).isConnected);
      verifyNoMoreInteractions(homeRemoteDataSource);
      verifyNoMoreInteractions(container.read(networkInfoProvider));
    });
    test(
        'should throw connection error if no internet connection after calling the method',
        () async {
      const requestCity = 'cairo';
      when(() => container.read(networkInfoProvider).isConnected)
          .thenAnswer((_) async => true);
      Future<WeatherModel> repoFunction() => container
          .read(homeRemoteDataSourceProvider)
          .getWeatherData(city: requestCity);

      when(repoFunction).thenThrow(const SocketException(''));

      expect(
          container
              .read(homeRepositoryProvider)
              .getWeatherData(city: requestCity),
          throwsA(isA<ConnectionFailure>()));
      verify(() => container.read(networkInfoProvider).isConnected);
      verifyNoMoreInteractions(homeRemoteDataSource);
      verifyNoMoreInteractions(container.read(networkInfoProvider));
    });
  });
  group('network not available before the request', () {
    test(
        'should throw connection error if no internet connection before calling the method',
        () async {
      const requestCity = 'cairo';
      when(() => container.read(networkInfoProvider).isConnected)
          .thenAnswer((_) async => false);
      Future<WeatherModel> repoFunction() => container
          .read(homeRemoteDataSourceProvider)
          .getWeatherData(city: requestCity);
      expect(
          container
              .read(homeRepositoryProvider)
              .getWeatherData(city: requestCity),
          throwsA(isA<ConnectionFailure>()));
      verify(() => container.read(networkInfoProvider).isConnected);
      verifyNoMoreInteractions(homeRemoteDataSource);
      verifyNoMoreInteractions(container.read(networkInfoProvider));
    });
  });
}

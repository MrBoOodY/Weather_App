import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weath_app/common/errors/failures.dart';
import 'package:weath_app/features/home_screen/data/model/weather_model.dart';
import 'package:weath_app/features/home_screen/domain/repositories/home_repository.dart';
import 'package:weath_app/features/home_screen/domain/use_cases/get_weather_data_use_case.dart';

import '../../../../fixtures/fixture_weather_model.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late final ProviderContainer container;

  late final HomeRepository homeRepository;
  setUpAll(() {
    container = ProviderContainer(
      overrides: [
        homeRepositoryProvider.overrideWith((ref) => MockHomeRepository()),
      ],
    );
    homeRepository = container.read(homeRepositoryProvider);
  });

  test('should get weather data with city successfully', () async {
    const requestCity = 'cairo';
    Future<WeatherModel> repoFunction() {
      return container
          .read(homeRepositoryProvider)
          .getWeatherData(city: requestCity);
    }

    when(repoFunction).thenAnswer((_) async => testWeatherModel);

    final result = await container
        .read(getWeatherDataUseCaseProvider(city: requestCity).future);
    expect(result, testWeatherModel);
    verify(repoFunction);
    verifyNoMoreInteractions(homeRepository);
  });

  test('should get weather data with lat and long successfully', () async {
    const lat = 30.05;
    const long = 31.25;
    Future<WeatherModel> repoFunction() => container
        .read(homeRepositoryProvider)
        .getWeatherData(lat: lat, long: long);
    when(repoFunction).thenAnswer((_) async => testWeatherModel);

    final result = await container
        .read(getWeatherDataUseCaseProvider(lat: lat, long: long).future);
    expect(result, testWeatherModel);
    verify(repoFunction);
    verifyNoMoreInteractions(homeRepository);
  });
  test('should throw server error if no data sent in the request', () async {
    Future<WeatherModel> repoFunction() =>
        container.read(homeRepositoryProvider).getWeatherData();
    when(repoFunction).thenThrow(const ServerFailure());

    expect(container.read(getWeatherDataUseCaseProvider().future),
        throwsA(isA<ServerFailure>()));
    verify(repoFunction);
    verifyNoMoreInteractions(homeRepository);
  });
  test('should throw connection error if no internet connection', () async {
    const requestCity = 'cairo';
    Future<WeatherModel> repoFunction() => container
        .read(homeRepositoryProvider)
        .getWeatherData(city: requestCity);
    when(repoFunction).thenThrow(const ConnectionFailure());

    expect(
        container.read(getWeatherDataUseCaseProvider(city: requestCity).future),
        throwsA(isA<ConnectionFailure>()));
    verify(repoFunction);
    verifyNoMoreInteractions(homeRepository);
  });
}

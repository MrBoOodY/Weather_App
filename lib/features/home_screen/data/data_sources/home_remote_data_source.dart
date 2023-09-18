import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weath_app/common/network/dio/dio_enum.dart';
import 'package:weath_app/common/network/dio/network_call.dart';
import 'package:weath_app/common/network/urls/end_points.dart';

import '../model/weather_model.dart';

part 'home_remote_data_source.g.dart';

@riverpod
HomeRemoteDataSource homeRemoteDataSource(HomeRemoteDataSourceRef ref) =>
    HomeRemoteDataSourceImpl(
      networkCall: ref.read(networkCallProvider),
    );

abstract class HomeRemoteDataSource {
  Future<WeatherModel> getWeatherData({
    String? city,
    double? lat,
    double? long,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NetworkCall networkCall;
  HomeRemoteDataSourceImpl({required this.networkCall});

  @override
  Future<WeatherModel> getWeatherData({
    String? city,
    double? lat,
    double? long,
  }) async {
    late final WeatherModel weatherModel;
    await networkCall.request<WeatherModel>(
      EndPoints.instance.currentWeatherData,
      fromJson: WeatherModel.fromJson,
      method: Method.get,
      queryParameters: {
        'q': city ?? '$lat,$long',
        'days': 5,
        'aqi': 'no',
        'alerts': 'no',
      },
      onSuccess: (data) {
        weatherModel = data;
      },
    );
    return weatherModel;
  }
}

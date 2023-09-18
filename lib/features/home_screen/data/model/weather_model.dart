import 'package:freezed_annotation/freezed_annotation.dart';

import 'five_days_model.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    required Location location,
    required CurrentWeather current,
    required FiveDaysModel forecast,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    required String name,
    required String region,
    required String country,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}

@freezed
class CurrentWeather with _$CurrentWeather {
  const CurrentWeather._();
  double getTempByCondition(bool isCelsius) => isCelsius ? temp_c : temp_f;
  const factory CurrentWeather({
    required double temp_c,
    required double temp_f,
    required WeatherCondition condition,
    required double wind_mph,
    required double wind_kph,
    required int humidity,
  }) = _CurrentWeather;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) =>
      _$CurrentWeatherFromJson(json);
}

@freezed
class WeatherCondition with _$WeatherCondition {
  const WeatherCondition._();
  String get iconFixedLink => icon.replaceFirst('//', 'https://');
  const factory WeatherCondition({
    required String text,
    required String icon,
    required int code,
  }) = _WeatherCondition;

  factory WeatherCondition.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

import 'weather_model.dart';

part 'five_days_model.freezed.dart';
part 'five_days_model.g.dart';

@freezed
class FiveDaysModel with _$FiveDaysModel {
  const factory FiveDaysModel({
    required List<ForecastDay> forecastday,
  }) = _FiveDaysModel;

  factory FiveDaysModel.fromJson(Map<String, dynamic> json) =>
      _$FiveDaysModelFromJson(json);
}

@freezed
class ForecastDay with _$ForecastDay {
  const factory ForecastDay({
    required DateTime date,
    required DayData day,
  }) = _ForecastDay;

  factory ForecastDay.fromJson(Map<String, dynamic> json) =>
      _$ForecastDayFromJson(json);
}

@freezed
class DayData with _$DayData {
  const DayData._();
  double getMinTempByCondition(bool isCelsius) =>
      isCelsius ? mintemp_c : mintemp_f;
  double getMaxTempByCondition(bool isCelsius) =>
      isCelsius ? maxtemp_c : maxtemp_f;
  double getAvgTempByCondition(bool isCelsius) =>
      isCelsius ? avgtemp_c : avgtemp_f;

  const factory DayData({
    required double maxtemp_c,
    required double maxtemp_f,
    required double mintemp_c,
    required double mintemp_f,
    required double avgtemp_c,
    required double avgtemp_f,
    required double maxwind_kph,
    required WeatherCondition condition,
  }) = _DayData;

  factory DayData.fromJson(Map<String, dynamic> json) =>
      _$DayDataFromJson(json);
}

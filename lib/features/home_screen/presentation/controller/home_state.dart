part of 'home_controller.dart';

@freezed
abstract class HomeState with _$HomeState {
  factory HomeState({
    final WeatherModel? currentWeather,
    @Default(true) final bool isCelsius,
    final String? city,
    @Default(30.0594885) final double lat,
    @Default(31.2584644) final double long,
  }) = _HomeState;
}

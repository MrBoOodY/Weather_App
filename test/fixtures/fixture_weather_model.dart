import 'package:weath_app/features/home_screen/data/model/five_days_model.dart';
import 'package:weath_app/features/home_screen/data/model/weather_model.dart';

import 'fixture_weather_condition.dart';

final WeatherModel testWeatherModel = WeatherModel(
  location: const Location(
    name: 'Cairo',
    region: 'Al Qahirah',
    country: 'Egypt',
  ),
  current: const CurrentWeather(
    temp_c: 34.0,
    temp_f: 93.2,
    condition: testWeatherCondition,
    wind_mph: 6.9,
    wind_kph: 11.2,
    humidity: 20,
  ),
  forecast: FiveDaysModel(
    forecastday: [
      ForecastDay(
        date: DateTime.now(),
        day: const DayData(
          maxtemp_c: 36.9,
          maxtemp_f: 98.4,
          mintemp_c: 22.8,
          mintemp_f: 73.0,
          avgtemp_c: 28.8,
          avgtemp_f: 83.9,
          maxwind_kph: 29.9,
          condition: testWeatherCondition,
        ),
      ),
    ],
  ),
);

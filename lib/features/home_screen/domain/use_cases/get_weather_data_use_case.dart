import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weath_app/features/home_screen/data/model/weather_model.dart';
import 'package:weath_app/features/home_screen/domain/repositories/home_repository.dart';

part 'get_weather_data_use_case.g.dart';

@riverpod
Future<WeatherModel> getWeatherDataUseCase(
  GetWeatherDataUseCaseRef ref, {
  String? city,
  double? lat,
  double? long,
}) {
  return ref.read(homeRepositoryProvider).getWeatherData(
        city: city,
        lat: lat,
        long: long,
      );
}

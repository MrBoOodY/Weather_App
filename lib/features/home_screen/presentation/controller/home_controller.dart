import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:location/location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weath_app/common/extension/async_value_extension.dart';
import 'package:weath_app/common/services/location_service/location_service.dart';
import 'package:weath_app/common/utils.dart';
import 'package:weath_app/features/home_screen/data/model/weather_model.dart';
import 'package:weath_app/features/home_screen/domain/use_cases/get_weather_data_use_case.dart';

part 'home_controller.freezed.dart';
part 'home_controller.g.dart';
part 'home_state.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  Future<HomeState> build() async {
    state = AsyncData(HomeState());
    state = const AsyncLoading();
    final location = await pickCurrentLocation();
    return await getData(lat: location?.latitude, long: location?.longitude);
  }

  Future<HomeState> getData({
    double? long,
    double? lat,
  }) async {
    return state.requireValue.copyWith(
      currentWeather: await getCurrentWeather(lat: lat, long: long),
    );
  }

  Future<WeatherModel> getCurrentWeather({
    double? long,
    double? lat,
  }) async {
    final result = await AsyncValue.guard(
      () => ref.read(
        getWeatherDataUseCaseProvider(
          city: state.requireValue.city,
          lat: lat ?? state.requireValue.lat,
          long: long ?? state.requireValue.long,
        ).future,
      ),
    );
    result.handleGuardResults(
      ref: ref,
      onError: () {
        throw result.error!;
      },
    );
    return result.requireValue;
  }

  Future<void> changeTempMode() async {
    state = AsyncData(
      state.requireValue.copyWith(
        isCelsius: !state.requireValue.isCelsius,
      ),
    );
  }

  Future<void> searchByCity(String city) async {
    state = AsyncData(
      state.requireValue.copyWith(
        city: city.isEmpty ? null : city,
      ),
    );

    final utils = ref.read(utilsProvider);

    utils.showLoading();
    LocationData? location;
    if (city.isEmpty) {
      location = await pickCurrentLocation();
    }
    state = await AsyncValue.guard(
        () => getData(lat: location?.latitude, long: location?.longitude));
    utils.hideLoading();
  }

  Future<LocationData?> pickCurrentLocation() async {
    final asyncValue = await AsyncValue.guard(
        () => ref.read(determinePositionProvider.future));

    asyncValue.handleGuardResults(ref: ref, onError: () {}, onSuccess: () {});
    return asyncValue.valueOrNull;
  }
}

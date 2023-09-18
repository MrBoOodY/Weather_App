import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weath_app/features/home_screen/data/model/weather_model.dart';

import '../../../../../common/network/connection/network_info.dart';
import '../../data/data_sources/home_remote_data_source.dart';
import '../../data/repositories/home_repository_impl.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl(
    remoteDataSource: ref.read(homeRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
}

abstract class HomeRepository {
  Future<WeatherModel> getWeatherData({
    String? city,
    double? lat,
    double? long,
  });
}

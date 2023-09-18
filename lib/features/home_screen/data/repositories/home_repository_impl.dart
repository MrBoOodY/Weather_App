import 'package:weath_app/common/helper/failure_helper.dart';
import 'package:weath_app/features/home_screen/data/model/weather_model.dart';

import '../../../../../common/network/connection/network_info.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<WeatherModel> getWeatherData(
      {String? city, double? lat, double? long}) {
    return FailureHelper.instance(
      method: () async {
        final result = await remoteDataSource.getWeatherData(
          city: city,
          lat: lat,
          long: long,
        );
        return result;
      },
      networkInfo: networkInfo,
    );
  }
}

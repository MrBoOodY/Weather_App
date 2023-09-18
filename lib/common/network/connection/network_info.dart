import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network_info.g.dart';

@riverpod
NetworkInfo networkInfo(NetworkInfoRef ref) {
  return NetworkInfoImpl(
    connectionChecker: ref.watch(internetConnectionCheckerProvider),
  );
}

@riverpod
InternetConnectionChecker internetConnectionChecker(
    InternetConnectionCheckerRef ref) {
  return InternetConnectionChecker.createInstance();
}

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({required this.connectionChecker});
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}

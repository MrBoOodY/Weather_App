import 'dart:developer';
import 'dart:io';

import 'package:weath_app/common/errors/exceptions.dart';
import 'package:weath_app/common/errors/failures.dart';
import 'package:weath_app/common/network/connection/network_info.dart';

class FailureHelper {
  static FailureHelper? _instance;
  FailureHelper._();
  static FailureHelper get instance {
    _instance ??= FailureHelper._();
    return _instance!;
  }

  Future<T> call<T>(
      {Future<T> Function()? method,
      NetworkInfo? networkInfo,
      Future<T> Function()? methodLocal}) async {
    assert((method != null || methodLocal != null),
        "There is an error you don't call method or methodLocal");

    if (networkInfo == null || await networkInfo.isConnected) {
      try {
        if (method != null) {
          return await method();
        } else {
          return call(method: methodLocal);
        }
      } on ServerException catch (error) {
        throw ServerFailure(message: error.message);
      } on UnAuthorizedException catch (error) {
        throw UnAuthorizedFailure(message: error.message);
      } on DatabaseException {
        throw const DatabaseFailure();
      } on UnRegisteredException {
        throw const UnRegisteredFailure();
      } on SocketException {
        throw const ConnectionFailure();
      } catch (error, trace) {
        log('Failure', stackTrace: trace, error: error, time: DateTime.now());

        throw ExceptionFailure(message: error.toString());
      }
    } else {
      if (methodLocal != null) {
        return call(method: methodLocal);
      } else {
        throw const ConnectionFailure();
      }
    }
  }

  T callNonFuture<T>({required T Function() methodLocal}) {
    try {
      return methodLocal();
    } on ServerException catch (error) {
      throw ServerFailure(message: error.message);
    } on UnAuthorizedException {
      throw const UnAuthorizedFailure();
    } on DatabaseException {
      throw const DatabaseFailure();
    } on UnRegisteredException {
      throw const UnRegisteredFailure();
    } on SocketException {
      throw const ConnectionFailure();
    } catch (error) {
      throw ExceptionFailure(message: error.toString());
    }
  }
}

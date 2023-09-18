import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weath_app/common/errors/exceptions.dart';
import 'package:weath_app/common/log/log.dart';
import 'package:weath_app/common/network/dio/base_response.dart';
import 'package:weath_app/common/network/dio/dio_enum.dart';
import 'package:weath_app/common/network/dio/status_code.dart';
import 'package:weath_app/common/network/urls/services_urls.dart';

import 'dio_helper.dart';

part 'network_call.g.dart';

@riverpod
NetworkCall networkCall<T>(NetworkCallRef ref) {
  return NetworkCall(dioHelper: ref.watch(dioHelperProvider));
}

class NetworkCall {
  final DioHelper _dioHelper;

  NetworkCall({required DioHelper dioHelper}) : _dioHelper = dioHelper;

  Future<Response> _request(String url,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      CancelToken? cancelToken,
      required Options options,
      void Function(int, int)? onSendProgress}) async {
    return await _dioHelper.dio.request(url,
        onSendProgress: onSendProgress,
        data: data,
        queryParameters: queryParameters
          ?..addEntries({const MapEntry('key', ServicesURLs.apiKey)}),
        options: options,
        cancelToken: cancelToken);
  }

  Future<void> request<T>(
    String url, {
    T Function(Map<String, dynamic> json)? fromJson,
    dynamic params,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required Method method,
    Function(T t)? onSuccess,
    Function(List<T> list)? onSuccessList,
  }) async {
    await _handleResponse<T>(
      onSuccess: onSuccess,
      onSuccessList: onSuccessList,
      fromJson: fromJson,
      _request(
        url,
        data: params,
        queryParameters: queryParameters,
        options: options?.copyWith(method: method.name) ??
            Options(method: method.name),
        cancelToken: cancelToken,
      ),
    );
  }

  Future<void> _handleResponse<T>(
    Future<Response> function, {
    required T Function(Map<String, dynamic> json)? fromJson,
    Function(T t)? onSuccess,
    Function(List<T> list)? onSuccessList,
  }) async {
    final response = await function;
    try {
      late final Map<String, dynamic> result;
      if (response.data is String) {
        result = jsonDecode(response.data);
      } else {
        result = response.data;
      }
      final BaseResponse baseResponse = BaseResponse<T>.fromJson(
        result,
        fromJson: fromJson,
      );
      baseResponse.code ??= response.statusCode;
      if (baseResponse.code == StatusCode.success ||
          baseResponse.code == StatusCode.created) {
        if (onSuccessList != null) {
          if (baseResponse.listData != null) {
            onSuccessList(baseResponse.listData as List<T>);
          }
        }
        if (onSuccess != null) {
          if (baseResponse.data != null) {
            onSuccess(baseResponse.data as T);
          } else {
            onSuccess((baseResponse.message ?? '') as T);
          }
        }
        return;
      } else if (baseResponse.code == StatusCode.unauthenticated) {
        throw UnAuthorizedException(
            message: baseResponse.error ?? baseResponse.message ?? '');
      } else if (baseResponse.code == StatusCode.forbidden) {
        throw const UnVerifiedException();
      } else {
        throw ServerException(
            message: baseResponse.error ?? baseResponse.message ?? '');
      }
    } on DioException catch (dioError) {
      if (dioError.error is SocketException ||
          dioError.type.name == 'connectionTimeout') {
        throw const SocketException('');
      }
      if (dioError.error is HttpException) {
        if ((dioError.error as HttpException)
            .message
            .toLowerCase()
            .contains('connection')) {
          throw SocketException((dioError.error as HttpException).message);
        }
      }
      if (dioError.response == null) {
        throw Exception();
      }

      final responseBody = dioError.response!.data;
      final response = dioError.response!;
      late final String errorMessage;
      if (responseBody['message'] is List) {
        errorMessage = responseBody['message'].first;
      } else {
        errorMessage = responseBody['message'];
      }
      if (response.statusCode == StatusCode.unauthenticated) {
        //back to splash screen
        throw UnAuthorizedException(message: errorMessage);
      } else if (response.statusCode == StatusCode.forbidden) {
        throw const UnVerifiedException();
      } else {
        throw ServerException(message: errorMessage);
      }
    } catch (error, trace) {
      if (error is ServerException) {
        Log.e(error.message.toString());
      } else {
        Log.e(error.toString());
      }
      Log.json(response.requestOptions.path.toString());
      Log.json(trace.toString());
      if (error is FormatException) {
        throw Exception();
      }
      rethrow;
    }
  }
}

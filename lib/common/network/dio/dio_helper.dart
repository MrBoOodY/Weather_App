import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../urls/services_urls.dart';
import 'interceptors.dart';

part 'dio_helper.g.dart';

@riverpod
DioHelper dioHelper(DioHelperRef ref) {
  return DioHelper();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class DioHelper {
  late Dio _dio;

  DioHelper() {
    createDio();
  }

  Dio get dio => _dio;

  void createDio() {
    _dio = Dio(createNewBaseOptions());

    _dio.interceptors.add(RequestsInspectorInterceptor());
    HttpOverrides.global = MyHttpOverrides();
  }

  static BaseOptions createNewBaseOptions(
      {baseUrl = ServicesURLs.developmentEnvironment,
      headers = const {
        "Accept": "application/json",
        'Content-Type': 'application/json',
      }}) {
    return BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.plain,
      headers: headers,
      validateStatus: (status) {
        return true;
      },

      connectTimeout: const Duration(milliseconds: 20000),

      ///The interval between receiving data before and after the response stream
      receiveTimeout: const Duration(milliseconds: 20000),
    );
  }
}

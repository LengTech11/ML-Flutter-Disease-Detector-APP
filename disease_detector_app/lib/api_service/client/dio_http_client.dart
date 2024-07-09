import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:disease_detector_app/config/app_config/app_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class BaseHttpClient {
  static late final Dio dio;

  static void init() {
    final BaseOptions options = BaseOptions(
      baseUrl: AppConfig.BASE_URL,
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
    );

    dio = Dio()
      ..options = options
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
          error: true,
          request: true));
  }
}

const JsonDecoder decoder = JsonDecoder();
const JsonEncoder encoder = JsonEncoder.withIndent('');

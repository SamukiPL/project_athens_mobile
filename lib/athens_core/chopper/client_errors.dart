import 'dart:io';

import 'package:dio/dio.dart';

class AuthException extends DioError {
  final int code = 401;

  AuthException(RequestOptions options) : super(
    requestOptions: options,
    type: DioErrorType.response
  );
}

class NetworkException extends DioError {
  NetworkException(RequestOptions options) : super(
      requestOptions: options,
      type: DioErrorType.connectTimeout
  );
}

class ServerException extends DioError {
  ServerException(RequestOptions options) : super(
      requestOptions: options,
      type: DioErrorType.response
  );
}

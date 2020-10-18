import 'dart:io';

import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/chopper/client_errors.dart';

abstract class Result<T> {}

class Success<T> implements Result<T> {

  final T result;

  Success(this.result);

}

class Failure<T> implements Result<T> {

  final Exception exception;

  Failure(this.exception) {
    if (exception is! DioError)
      throw exception;
  }

}


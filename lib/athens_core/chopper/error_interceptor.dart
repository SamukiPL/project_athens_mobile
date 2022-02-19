
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/auth/auth_storage.dart';
import 'package:project_athens/athens_core/chopper/client_errors.dart';

class ErrorInterceptor extends Interceptor {

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch(err.type) {
      case DioErrorType.receiveTimeout:
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.other:
        throw NetworkException(err.requestOptions);
      case DioErrorType.response:
      case DioErrorType.cancel:
        if (err.response?.statusCode == 401) {
          removeInvalidToken();
          throw AuthException(err.requestOptions);
        }

        informAboutServerErrors(err);
        throw ServerException(err.requestOptions);
    }
  }

  void removeInvalidToken() {
    final authStorage = AuthStorage();
    authStorage.removeTokens();
  }

  void informAboutServerErrors(DioError err) {
    if (err.response?.statusCode != null && err.response!.statusCode! >= 500) {
      FirebaseCrashlytics.instance.recordFlutterError(FlutterErrorDetails(exception: err.response.toString()));
    }
  }
}

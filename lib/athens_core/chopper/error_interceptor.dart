import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/chopper/client_errors.dart';

class ErrorInterceptor extends Interceptor {

  void informAboutServerErrors(Response response) {
    if (response.statusCode >= 500) {
      FirebaseCrashlytics.instance.recordFlutterError(FlutterErrorDetails(exception: response.toString()));
    }
  }

  @override
  Future onResponse(Response<dynamic> response) async {
    informAboutServerErrors(response);
    if(response.statusCode == 401) {
      throw AuthException();
    }
    return response;
  }

}
import 'dart:async';

import 'package:athens_core/chopper/client_errors.dart';
import 'package:chopper/chopper.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

class ErrorInterceptor extends ResponseInterceptor {

  @override
  FutureOr<Response> onResponse(Response response) {
    informAboutServerErrors(response);
    switch (response.statusCode) {
      case 400:
        throw BadRequestError();
        break;
      case 401:
        throw UnauthorizedError();
        break;
      case 403:
        throw ForbiddenError();
        break;
      case 404:
        throw NotFoundError();
        break;
      case 405:
        throw MethodNotAllowedError();
        break;
    }
    return response;
  }

  void informAboutServerErrors(Response response) {
    if (response.statusCode >= 500) {
      Crashlytics.instance.recordFlutterError(FlutterErrorDetails(exception: response.toString()));
    }
  }

}
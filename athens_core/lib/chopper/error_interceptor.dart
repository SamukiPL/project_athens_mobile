import 'dart:async';

import 'package:athens_core/chopper/client_errors.dart';
import 'package:chopper/chopper.dart';

class ErrorInterceptor extends ResponseInterceptor {

  @override
  FutureOr<Response> onResponse(Response response) {
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

}
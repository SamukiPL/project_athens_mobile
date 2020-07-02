import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_fimber/flutter_fimber.dart';

class LoggingInterceptor implements RequestInterceptor, ResponseInterceptor {

  @override
  FutureOr<Request> onRequest(Request request) {
    Fimber.i(request.headers.toString());
    Fimber.i(request.body);
    return request;
  }

  @override
  FutureOr<Response> onResponse(Response response) {
    Fimber.i(response.headers.toString());
    Fimber.i(response.body.toString());
    return response;
  }

}
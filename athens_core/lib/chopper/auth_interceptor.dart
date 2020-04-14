import 'dart:async';

import 'package:athens_core/chopper/auth_facade.dart';
import 'package:chopper/chopper.dart';

class AuthInterceptor implements RequestInterceptor {

  final AuthFacade authFacade;

  AuthInterceptor(this.authFacade);

  @override
  FutureOr<Request> onRequest(Request request) async {
    final accessToken = await authFacade.accessToken;

    request.headers.addAll({ "Authorization": accessToken});

    return request;
  }

}
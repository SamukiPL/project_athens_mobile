import 'dart:async';

import 'package:project_athens/athens_core/chopper/auth_facade.dart';
import 'package:chopper/chopper.dart';

class AuthInterceptor implements RequestInterceptor {

  final AuthFacade authFacade;

  AuthInterceptor(this.authFacade);

  @override
  FutureOr<Request> onRequest(Request request) async {
    final accessToken = await authFacade.accessToken;

    Map<String, String> authHeaders = {"Authorization": "bearer $accessToken"};

    return applyHeaders(request, authHeaders);
  }

}
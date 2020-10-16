import 'dart:async';

import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/chopper/auth_facade.dart';

class AuthInterceptor implements Interceptor {
  final AuthFacade _authFacade;

  AuthInterceptor(this._authFacade) : super();

  @override
  Future onRequest(RequestOptions options) async {
    final accessToken = await _authFacade.accessToken;

    Map<String, String> authHeaders = {"Authorization": "bearer $accessToken"};

    options.headers.addAll(authHeaders);
  }

  @override
  Future onError(DioError err) async {}

  @override
  Future onResponse(Response response) async {}
}
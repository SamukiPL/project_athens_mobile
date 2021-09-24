
import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/chopper/auth_facade.dart';

class AuthInterceptor extends Interceptor {
  final AuthFacade _authFacade;

  AuthInterceptor(this._authFacade) : super();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await _authFacade.accessToken;

    Map<String, String> authHeaders = {"Authorization": "bearer $accessToken"};

    options.headers.addAll(authHeaders);
    handler.next(options);
  }
}

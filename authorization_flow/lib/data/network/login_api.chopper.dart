// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_api.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$LoginApi extends LoginApi {
  _$LoginApi([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = LoginApi;

  @override
  Future<Response<dynamic>> logIn(LoginRequest request) {
    final $url = '/user-aggregator/auth/login';
    final $body = request;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> resetPassword(ResetPasswordRequest request) {
    final $url = '/user-aggregator/auth/reset-password';
    final $body = request;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}

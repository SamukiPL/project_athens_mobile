import 'dart:io';

import 'package:athens_core/auth/auth_storage.dart';
import 'package:authorization_flow/data/network/request/login_request.dart';
import 'package:authorization_flow/data/network/response/login_response.dart';
import 'package:authorization_flow/domain/login/login_params.dart';
import 'package:authorization_flow/domain/login/login_repository.dart';
import 'package:authorization_flow/domain/login/login_response.dart';

import 'network/login_api.dart';

class LoginRepositoryImpl implements LoginRepository {

  final LoginApi api;

  final AuthStorage storage = AuthStorage();

  LoginRepositoryImpl(this.api);

  @override
  Future<LoginStatus> logIn(LoginParams params) async {
    try {
      var response = await api.logIn(LoginRequest(params.login, params.password));
      var loginResponse = LoginResponse.fromJson(response.body);

      await storage.saveTokens(loginResponse.accessToken, loginResponse.refreshToken);

      return LoginStatus.SUCCESS;
    } on SocketException {
      return LoginStatus.NETWORK_FAILURE;
    } on NoSuchMethodError {
      return LoginStatus.AUTH_FAILURE;
    }
  }

}
import 'package:project_athens/athens_core/auth/auth_storage.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/authorization_flow/data/network/request/login_request.dart';
import 'package:project_athens/authorization_flow/domain/login/login_params.dart';
import 'package:project_athens/authorization_flow/domain/login/login_repository.dart';

import 'network/login_api.dart';

class LoginRepositoryImpl implements LoginRepository {

  final LoginApi api;

  final AuthStorage storage = AuthStorage();

  LoginRepositoryImpl(this.api);

  @override
  Future<Result> logIn(LoginParams params) async {
    var response = await api.logIn(LoginRequest(params.login, params.email, params.password));

    await storage.saveTokens(response.accessToken, response.refreshToken);

    return Success<bool>(true);
  }

}
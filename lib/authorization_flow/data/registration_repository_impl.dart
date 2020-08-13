import 'package:project_athens/athens_core/auth/auth_storage.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/authorization_flow/data/network/login_api.dart';
import 'package:project_athens/authorization_flow/data/network/request/check_pair_usage_request.dart';
import 'package:project_athens/authorization_flow/data/network/request/registration_request.dart';
import 'package:project_athens/authorization_flow/data/network/response/check_pair_usage_response.dart';
import 'package:project_athens/authorization_flow/data/network/response/login_response.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_model.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_params.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_params.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_repository.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  final LoginApi api;

  final AuthStorage storage = AuthStorage();

  RegistrationRepositoryImpl(this.api);

  @override
  Future<Result<CheckPairUsageModel>> checkPairUsage(
      CheckPairUsageParams params) async {
    final response = await api
        .checkAccountPairUsage(CheckPairUsageRequest.fromParams(params));
    var checkResponse = CheckPairUsageResponse.fromJson(response.body);

    return Success<CheckPairUsageModel>(CheckPairUsageModel(
        loginTaken: checkResponse.usernameTaken,
        emailTaken: checkResponse.emailTaken));
  }

  @override
  Future<Result> register(RegistrationParams params) async {
    final response = await api.register(RegistrationRequest.fromParams(params));
    var loginResponse = LoginResponse.fromJson(response.body);

    await storage.saveTokens(
        loginResponse.accessToken, loginResponse.refreshToken);

    return Success<bool>(true);
  }
}

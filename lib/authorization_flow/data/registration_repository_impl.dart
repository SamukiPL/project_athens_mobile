import 'package:project_athens/athens_core/auth/auth_storage.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/authorization_flow/data/network/login_api.dart';
import 'package:project_athens/authorization_flow/data/network/request/check_pair_usage_request.dart';
import 'package:project_athens/authorization_flow/data/network/request/registration_request.dart';
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

    return Success<CheckPairUsageModel>(CheckPairUsageModel(
        loginTaken: response.usernameTaken, emailTaken: response.emailTaken));
  }

  @override
  Future<Result> register(RegistrationParams params) async {
    final response = await api.register(RegistrationRequest.fromParams(params));

    await storage.saveTokens(response.accessToken, response.refreshToken);

    return Success<bool>(true);
  }
}

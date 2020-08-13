import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_model.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_params.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_params.dart';

abstract class RegistrationRepository {

  Future<Result<CheckPairUsageModel>> checkPairUsage(CheckPairUsageParams params);

  Future<Result> register(RegistrationParams params);

}
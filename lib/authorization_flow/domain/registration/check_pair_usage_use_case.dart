import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_params.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_repository.dart';

class CheckPairUsageUseCase extends BaseUseCase<CheckPairUsageParams> {

  final RegistrationRepository _registrationRepository;

  CheckPairUsageUseCase(this._registrationRepository);

  @override
  Future<Result> call(CheckPairUsageParams params) {
    return _registrationRepository.checkPairUsage(params);
  }

}
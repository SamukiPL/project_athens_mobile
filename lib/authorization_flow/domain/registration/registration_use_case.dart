import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_params.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_repository.dart';

class RegistrationUseCase extends BaseUseCase<RegistrationParams> {

  final RegistrationRepository _registrationRepository;

  RegistrationUseCase(this._registrationRepository);

  @override
  Future<Result> call(RegistrationParams params) {
    return _registrationRepository.register(params);
  }

}
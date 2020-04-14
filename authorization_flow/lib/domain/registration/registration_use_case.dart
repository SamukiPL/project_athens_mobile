import 'package:athens_core/domain/base_use_case.dart';
import 'package:athens_core/domain/result.dart';
import 'package:authorization_flow/domain/registration/registration_repository.dart';

class RegistrationUseCase extends BaseUseCase {

  final RegistrationRepository _registrationRepository;

  RegistrationUseCase(this._registrationRepository);

  @override
  Future<Result> call(params) {
    return _registrationRepository.register(params);
  }

}
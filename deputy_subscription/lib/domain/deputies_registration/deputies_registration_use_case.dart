import 'package:athens_core/domain/base_use_case.dart';
import 'package:athens_core/domain/result.dart';

import 'package:deputy_subscription/domain/deputies_registration/deputies_registration_params.dart';
import 'package:deputy_subscription/domain/deputies_registration/deputies_registration_repository.dart';
import 'package:deputy_subscription/domain/deputies_registration/deputy_model.dart';

class DeputiesRegistrationUseCase extends BaseUseCase<DeputiesRegistrationParams> {

  final DeputiesRegistrationRepository _repository;

  DeputiesRegistrationUseCase(this._repository);

  @override
  Future<Result<List<DeputyModel>>> call(DeputiesRegistrationParams params) {
    return _repository.getDeputies(params);
  }

}
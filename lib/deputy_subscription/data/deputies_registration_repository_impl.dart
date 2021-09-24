import 'package:project_athens/athens_core/domain/result.dart';

import 'package:project_athens/deputy_subscription/domain/deputies_registration/deputies_registration_params.dart';
import 'package:project_athens/deputy_subscription/domain/deputies_registration/deputies_registration_repository.dart';
import 'package:project_athens/deputy_subscription/domain/deputies_registration/deputy_model.dart';

class DeputiesRegistrationRepositoryImpl
    implements DeputiesRegistrationRepository {
  // final DeputiesApi deputiesApi;
  //
  // DeputiesRegistrationRepositoryImpl(this.deputiesApi);

  @override
  Future<Result<List<DeputyModel>>> getDeputies(
      DeputiesRegistrationParams params) async {
    // var response = await deputiesApi.getAllDeputies(params.cadency);

    return Success<List<DeputyModel>>(List.empty());
  }
}

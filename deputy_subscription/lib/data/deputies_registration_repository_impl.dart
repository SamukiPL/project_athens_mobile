import 'package:athens_core/domain/result.dart';

import 'package:deputy_subscription/domain/deputies_registration/deputies_registration_params.dart';
import 'package:deputy_subscription/domain/deputies_registration/deputies_registration_repository.dart';
import 'package:deputy_subscription/domain/deputies_registration/deputy_model.dart';
import 'network/deputies_api.dart';

class DeputiesRegistrationRepositoryImpl implements DeputiesRegistrationRepository {

  final DeputiesApi deputiesApi;

  DeputiesRegistrationRepositoryImpl(this.deputiesApi);

  @override
  Future<Result<List<DeputyModel>>> getDeputies(DeputiesRegistrationParams params) async {
    var response = await deputiesApi.getAllDeputies(params.cadency);

    return Success<List<DeputyModel>>(List());
  }

}
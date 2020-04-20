import 'package:athens_core/domain/result.dart';
import 'package:authorization_flow/data/network/response/deputy_response.dart';
import 'package:authorization_flow/domain/deputies_registration/deputies_registration_params.dart';
import 'package:authorization_flow/domain/deputies_registration/deputies_registration_repository.dart';
import 'package:authorization_flow/domain/deputies_registration/deputy_model.dart';
import 'network/deputies_api.dart';

class DeputiesRegistrationRepositoryImpl
    implements DeputiesRegistrationRepository {
  final DeputiesApi deputiesApi;

  DeputiesRegistrationRepositoryImpl(this.deputiesApi);

  @override
  Future<Result<List<DeputyModel>>> getDeputies(
      DeputiesRegistrationParams params) async {
    final response = await deputiesApi.getAllDeputies(params.cadency);
    final deputies = (response.body as List)
        .map((json) => DeputyResponse.fromJson(json))
        .toList();

    return Success<List<DeputyModel>>(
        deputies.map((response) => responseToModel(response)).toList());
  }

  DeputyModel responseToModel(DeputyResponse response) =>
      DeputyModel(name: response.name);
}

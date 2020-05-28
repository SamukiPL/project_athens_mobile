import 'package:athens_core/domain/result.dart';
import 'package:authorization_flow/data/network/request/deputy_request.dart';
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

  @override
  Future<Result> putDeputies(
      DeputiesRegistrationParams params, List<DeputyModel> models) async {
    final request = DeputyRequest(models
        .map((model) => Deputy(model.deputyId, Notifications()))
        .toList());
    final response = await deputiesApi.putDeputies(params.cadency, request);
    return Success<int>(response.statusCode);
  }

  DeputyModel responseToModel(DeputyResponse response) =>
      DeputyModel(deputyId: response.deputyId, name: response.name, thumbnailUrl: response.photoUrl, club: response.parliamentClub);
}

import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/authorization_flow/data/network/login_api.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_repository.dart';

import 'network/deputies_api.dart';

class GetDeputiesRepositoryImpl
    implements GetDeputiesRepository {
  final LoginApi _loginApi;

  GetDeputiesRepositoryImpl(this._loginApi);

  @override
  Future<Result<List<DeputyModel>>> getDeputies(
      GetDeputiesParams params) async {
    final response = await _loginApi.getAllDeputies(params.cadency);
    final deputies = (response.body as List)
        .map((json) => DeputyResponse.fromJson(json))
        .toList();

    return Success<List<DeputyModel>>(
        deputies.map((response) => responseToModel(response)).toList());
  }

  DeputyModel responseToModel(DeputyResponse response) =>
      DeputyModel(deputyId: response.deputyId, name: response.name, thumbnailUrl: response.photoUrl, club: response.parliamentClub);
}

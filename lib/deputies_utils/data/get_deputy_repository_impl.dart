import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/base_deputy_params.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy/get_deputy_repository.dart';

import 'network/deputies_api.dart';
import 'network/response/deputy_response.dart';

class GetDeputyRepositoryImpl
    implements GetDeputyRepository {
  final DeputiesApi _deputiesApi;

  GetDeputyRepositoryImpl(this._deputiesApi);

  @override
  Future<Result<DeputyResponse>> getDeputy(
      BaseDeputyParams params) async {
    final response = await _deputiesApi.getDeputy(params.deputyId);

    return Success<DeputyResponse>(response);
  }
}

import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_nouns_response.dart';
import 'package:project_athens/deputies_utils/domain/base_deputy_params.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy_nouns/get_deputy_nouns_repository.dart';

import 'network/deputies_api.dart';

class GetDeputyNounsRepositoryImpl
    implements GetDeputyNounsRepository {
  final DeputiesApi _deputiesApi;

  GetDeputyNounsRepositoryImpl(this._deputiesApi);

  @override
  Future<Result<DeputyNounsResponse>> getDeputyNouns(
      BaseDeputyParams params) async {
    final response = await _deputiesApi.getDeputyNouns(params.deputyId);

    return Success<DeputyNounsResponse>(response);
  }
}

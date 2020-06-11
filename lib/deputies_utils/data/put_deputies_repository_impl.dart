import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/data/network/request/put_deputies_request.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_repository.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputies_params.dart';

import 'network/deputies_api.dart';

class PutDeputiesRepositoryImpl
    implements PutDeputiesRepository {
  final DeputiesApi deputiesApi;

  PutDeputiesRepositoryImpl(this.deputiesApi);

  @override
  Future<Result> putDeputies(
      PutDeputiesParams params) async {
    final request = PutDeputiesRequest(params.deputies
        .map((model) => Deputy(model.deputyId, Notifications(model.vote, model.speech, model.interpolation)))
        .toList());
    final response = await deputiesApi.putDeputies(params.cadency, request);
    return Success<int>(response.statusCode);
  }
}

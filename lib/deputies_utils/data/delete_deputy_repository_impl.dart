import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/utils/firebase/firebase_deputy_subscriber.dart';
import 'package:project_athens/deputies_utils/domain/delete_deputy/delete_deputy_params.dart';
import 'package:project_athens/deputies_utils/domain/delete_deputy/delete_deputy_repository.dart';

import 'network/deputies_api.dart';

class DeleteDeputyRepositoryImpl
    implements DeleteDeputyRepository {
  final DeputiesApi _deputiesApi;
  final FirebaseDeputySubscriber _deputySubscriber;

  DeleteDeputyRepositoryImpl(this._deputiesApi, this._deputySubscriber);

  @override
  Future<Result<void>> deleteDeputy(
      DeleteDeputyParams params) async {
    final response = await _deputiesApi.deleteDeputy(params.cadencyDeputyId);

    await _deputySubscriber.unsubscribeDeputy(params.cadencyDeputyId);

    return Success<void>(response);
  }
}

import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_repository.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class FirebaseDeputiesUseCase extends BaseUseCase<BaseDeputiesParams> {

  final FirebaseDeputiesRepository _firebaseDeputiesRepository;

  FirebaseDeputiesUseCase(this._firebaseDeputiesRepository);

  @override
  Future<Result<List<SubscribedDeputyModel>>> call(BaseDeputiesParams params) {
    return _firebaseDeputiesRepository.initFirebaseDeputies(params).safeApiCall();
  }
}

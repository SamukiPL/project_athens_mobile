import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_repository.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class FirebaseDeputiesUseCase extends BaseUseCase {

  final FirebaseDeputiesRepository _firebaseDeputiesRepository;

  FirebaseDeputiesUseCase(this._firebaseDeputiesRepository);

  Future<Result<List<SubscribedDeputyModel>>> call() {
    return _firebaseDeputiesRepository.initFirebaseDeputies().safeApiCall();
  }
}

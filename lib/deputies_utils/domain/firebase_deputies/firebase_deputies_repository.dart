import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

abstract class FirebaseDeputiesRepository {

  Future<Result<List<SubscribedDeputyModel>>> initFirebaseDeputies();

}
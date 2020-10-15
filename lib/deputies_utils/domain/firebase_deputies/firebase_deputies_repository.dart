import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';

abstract class FirebaseDeputiesRepository {

  Future<Result<bool>> initFirebaseDeputies(BaseDeputiesParams params);

}
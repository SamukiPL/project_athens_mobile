import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';

abstract class FirebaseDeputiesRepository {

  Future<void> initFirebaseDeputies(BaseDeputiesParams params);

}
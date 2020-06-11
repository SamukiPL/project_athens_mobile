import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputies_params.dart';


abstract class PutDeputiesRepository {

 Future<Result> putDeputies(PutDeputiesParams params);

}
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_params.dart';


abstract class GetDeputiesRepository {

  Future<Result<List<DeputyModel>>> getDeputies(GetDeputiesParams params);

}
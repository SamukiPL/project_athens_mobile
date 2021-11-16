import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';

abstract class GetDeputiesRepository {
  Future<Result<List<DeputyModel>>> getDeputies(BaseDeputiesParams params);
}

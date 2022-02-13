import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';

abstract class GetDeputiesRepository {
  Future<Result<List<DeputyModel>>> getDeputies();
}

import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/delete_deputy/delete_deputy_params.dart';

abstract class DeleteDeputyRepository {

  Future<Result<void>> deleteDeputy(DeleteDeputyParams params);

}
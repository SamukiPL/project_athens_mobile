import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_repository.dart';

class GetDeputiesUseCase extends BaseUseCase {
  final GetDeputiesRepository _repository;

  GetDeputiesUseCase(this._repository);

  Future<Result<List<DeputyModel>>> call() {
    return _repository.getDeputies().safeApiCall();
  }
}

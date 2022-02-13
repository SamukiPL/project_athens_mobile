import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/base_deputy_params.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';

import 'get_deputy_repository.dart';

class GetDeputyUseCase extends BaseUseCase {
  final GetDeputyRepository _repository;

  GetDeputyUseCase(this._repository);

  Future<Result<DeputyFull>> call(BaseDeputyParams params) {
    return _repository.getDeputy(params).safeApiCall();
  }
}

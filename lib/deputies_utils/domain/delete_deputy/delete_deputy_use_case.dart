import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/delete_deputy/delete_deputy_params.dart';

import 'delete_deputy_repository.dart';

class DeleteDeputyUseCase extends BaseUseCase<DeleteDeputyParams> {

  final DeleteDeputyRepository _deleteDeputyRepository;

  DeleteDeputyUseCase(this._deleteDeputyRepository);

  @override
  Future<Result<void>> call(DeleteDeputyParams params) {
    return _deleteDeputyRepository.deleteDeputy(params);
  }

}
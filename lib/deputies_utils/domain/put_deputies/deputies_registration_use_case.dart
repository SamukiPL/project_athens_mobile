import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/deputies_registration_repository.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputies_params.dart';

class PutDeputiesUseCase extends BaseUseCase<PutDeputiesParams> {

  final PutDeputiesRepository _repository;

  PutDeputiesUseCase(this._repository);

  @override
  Future<Result> call(PutDeputiesParams params) {
    return _repository.putDeputies(params);
  }

}
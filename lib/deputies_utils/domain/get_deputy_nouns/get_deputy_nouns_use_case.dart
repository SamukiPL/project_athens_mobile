import 'package:project_athens/athens_core/data/word_model/word_model.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/base_deputy_params.dart';

import 'get_deputy_nouns_repository.dart';

class GetDeputyNounsUseCase extends BaseUseCase<BaseDeputyParams> {

  final GetDeputyNounsRepository _repository;

  GetDeputyNounsUseCase(this._repository);

  @override
  Future<Result<List<WordModel>>> call(BaseDeputyParams params) {
    return _repository.getDeputyNouns(params).safeApiCall();
  }

}
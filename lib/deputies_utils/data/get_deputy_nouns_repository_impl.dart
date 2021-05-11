import 'package:project_athens/athens_core/data/word_model/word_model.dart';
import 'package:project_athens/athens_core/data/word_model/word_model_mapper.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/base_deputy_params.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy_nouns/get_deputy_nouns_repository.dart';

import 'network/deputies_api.dart';

class GetDeputyNounsRepositoryImpl
    implements GetDeputyNounsRepository {
  final DeputiesApi _deputiesApi;

  GetDeputyNounsRepositoryImpl(this._deputiesApi);

  @override
  Future<Result<List<WordModel>>> getDeputyNouns(
      BaseDeputyParams params) async {
    final response = await _deputiesApi.getDeputyNouns(params.deputyId);

    final words = mapToWordModel(response.nouns);

    return Success<List<WordModel>>(words);
  }
}

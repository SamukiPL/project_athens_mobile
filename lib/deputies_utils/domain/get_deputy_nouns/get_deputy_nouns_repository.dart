import 'package:project_athens/athens_core/data/word_model/word_model.dart';
import 'package:project_athens/athens_core/domain/result.dart';

import '../base_deputy_params.dart';

abstract class GetDeputyNounsRepository {

  Future<Result<List<WordModel>>> getDeputyNouns(BaseDeputyParams params);

}
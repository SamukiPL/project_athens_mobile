import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_nouns_response.dart';

import '../base_deputy_params.dart';

abstract class GetDeputyNounsRepository {

  Future<Result<DeputyNounsResponse>> getDeputyNouns(BaseDeputyParams params);

}
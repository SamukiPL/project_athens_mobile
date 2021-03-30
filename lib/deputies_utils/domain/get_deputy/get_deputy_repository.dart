import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';

import '../base_deputy_params.dart';

abstract class GetDeputyRepository {

  Future<Result<DeputyResponse>> getDeputy(BaseDeputyParams params);

}
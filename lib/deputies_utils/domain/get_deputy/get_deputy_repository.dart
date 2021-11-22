import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/domain/deputy_full.dart';

import '../base_deputy_params.dart';

abstract class GetDeputyRepository {

  Future<Result<DeputyFull>> getDeputy(BaseDeputyParams params);

}
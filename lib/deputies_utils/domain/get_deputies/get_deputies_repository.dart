import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';


abstract class GetDeputiesRepository {

  Future<Result<List<DeputyResponse>>> getDeputies(BaseDeputiesParams params);

}
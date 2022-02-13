import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputy_model.dart';

class PutDeputiesParams extends BaseParams {

  final List<PutDeputyModel> deputies;

  PutDeputiesParams(this.deputies);
}

import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputy_model.dart';

class PutDeputiesParams extends BaseDeputiesParams {

  final List<PutDeputyModel> deputies;

  PutDeputiesParams(int cadency, this.deputies) : super(cadency);

}
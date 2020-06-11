import 'package:project_athens/deputies_utils/domain/put_deputies/put_deputy_model.dart';

class PutDeputiesParams {

  final int cadency;

  final List<PutDeputyModel> deputies;

  PutDeputiesParams(this.cadency, this.deputies);

}
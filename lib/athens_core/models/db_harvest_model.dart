import 'package:project_athens/athens_core/domain/base_list/base_model.dart';

class DbHarvestModel extends BaseModel {
  final DateTime updateAt;
  final DateTime createAt;
  final String source = 'https://sejm.gov.pl';

  DbHarvestModel(this.createAt, this.updateAt);
}
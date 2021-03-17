import 'package:project_athens/athens_core/domain/list/base_params.dart';

class SpeechesListByDeputyParams extends BaseParams {
  final String cadencyDeputyId;

  SpeechesListByDeputyParams(this.cadencyDeputyId);
}
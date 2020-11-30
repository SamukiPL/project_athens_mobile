import 'package:project_athens/athens_core/domain/list/base_params.dart';

class DeputiesListParams extends BaseParams {

  final List<String> deputyIdsToShow;

  DeputiesListParams({this.deputyIdsToShow});

}
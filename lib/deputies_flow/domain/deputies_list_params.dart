import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputies_easy_filter.dart';

class DeputiesListParams extends BaseParams {
  
  final String searchQuery;
  final DeputiesEasyFilter? easyFilter;

  DeputiesListParams({required this.searchQuery, this.easyFilter});

}

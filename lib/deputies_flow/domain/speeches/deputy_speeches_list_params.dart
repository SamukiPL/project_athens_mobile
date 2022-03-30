import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputy_speeches_easy_filter.dart';
import 'package:project_athens/speeches_flow/domain/filters/speeches_easy_filter.dart';

class DeputySpeechesListParams extends BaseListParams {
  final DeputySpeechesEasyFilter? easyFilter;

  DeputySpeechesListParams(
      {this.easyFilter, required limit, required offset, required searchQuery, from, to, required sortingParam})
      : super(searchQuery: searchQuery, sortingParam: sortingParam, offset: offset, limit: limit, from: from, to: to);
}

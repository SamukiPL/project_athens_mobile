import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/speeches_flow/domain/filters/speeches_easy_filter.dart';

class SpeechesListParams extends BaseListParams {
  final SpeechesEasyFilter? easyFilter;

  SpeechesListParams({
    this.easyFilter,
    required limit,
    required offset,
    required searchQuery,
    from,
    to,
    required sortingParam
  }) : super(
      searchQuery: searchQuery,
      sortingParam: sortingParam,
      offset: offset,
      limit: limit,
      from: from,
      to: to
  );
}
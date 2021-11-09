import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/voting_flow/domain/filters/votes_easy_filter.dart';

class VotesListParams extends BaseListParams {
  final VotesEasyFilter? easyFilter;

  VotesListParams({
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

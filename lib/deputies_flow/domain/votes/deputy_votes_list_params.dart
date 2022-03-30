import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputy_votes_easy_filter.dart';

class DeputyVotesListParams extends BaseListParams {
  final DeputyVotesEasyFilter? easyFilter;

  DeputyVotesListParams(
      {this.easyFilter, required limit, required offset, required searchQuery, from, to, required sortingParam})
      : super(searchQuery: searchQuery, sortingParam: sortingParam, offset: offset, limit: limit, from: from, to: to);
}

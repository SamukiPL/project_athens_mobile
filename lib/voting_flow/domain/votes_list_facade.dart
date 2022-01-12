import 'package:project_athens/athens_core/ads/domain/ads_facade.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/base_list/items_repository.dart';
import 'package:project_athens/athens_core/domain/base_list_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/easy_filters/easy_filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filters_facade.dart';
import 'package:project_athens/voting_flow/domain/filters/votes_easy_filter.dart';
import 'package:project_athens/voting_flow/domain/votes_list_params.dart';

class VotesListFacade extends BaseListFacade
    with EasyFiltersFacade<VotesEasyFilter>, AdsFacade<BaseListParams> {
  VotesListFacade(
      ItemsRepository itemsRepository,
      FiltersRepository filtersRepository,
      this.easyFiltersRepository)
      : super(itemsRepository, filtersRepository);

  @override
  final EasyFiltersRepository<VotesEasyFilter> easyFiltersRepository;

  @override
  VotesListParams getParams({int limit = 20, int offset = 0}) =>
      VotesListParams(
          searchQuery: searchQuery,
          easyFilter: easyFilterValue,
          limit: limit,
          offset: offset,
          sortingParam: sortingParam,
          to: to,
          from: from
      );
}

import 'package:project_athens/athens_core/ads/domain/ads_facade.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/base_list/items_repository.dart';
import 'package:project_athens/athens_core/domain/base_list_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/easy_filters/easy_filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filters_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/types/sorting_filter.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputy_votes_easy_filter.dart';
import 'package:project_athens/deputies_flow/domain/votes/deputy_votes_list_params.dart';

class DeputyVotesListFacade extends BaseListFacade
    with EasyFiltersFacade<DeputyVotesEasyFilter>, AdsFacade<BaseListParams> {
  DeputyVotesListFacade(
      ItemsRepository itemsRepository, FiltersRepository filtersRepository, this.easyFiltersRepository)
      : super(itemsRepository, filtersRepository);

  @override
  final EasyFiltersRepository<DeputyVotesEasyFilter> easyFiltersRepository;

  @override
  String sortingParam = "DESC";

  @override
  DeputyVotesListParams getParams({int limit = 20, int offset = 0}) => DeputyVotesListParams(
      searchQuery: searchQuery,
      easyFilter: easyFilterValue,
      limit: limit,
      offset: offset,
      sortingParam: sortingParam,
      to: to,
      from: from);
}

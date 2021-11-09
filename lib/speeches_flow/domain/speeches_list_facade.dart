import 'package:project_athens/athens_core/domain/base_list/items_repository.dart';
import 'package:project_athens/athens_core/domain/base_list_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/easy_filters/easy_filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filters_facade.dart';
import 'package:project_athens/speeches_flow/domain/filters/speeches_easy_filter.dart';
import 'package:project_athens/speeches_flow/domain/speeches_list_params.dart';

class SpeechesListFacade extends BaseListFacade
    with EasyFiltersFacade<SpeechesEasyFilter> {
  SpeechesListFacade(
      ItemsRepository itemsRepository,
      FiltersRepository filtersRepository,
      this.easyFiltersRepository)
      : super(itemsRepository, filtersRepository);

  @override
  final EasyFiltersRepository<SpeechesEasyFilter> easyFiltersRepository;

  @override
  SpeechesListParams getParams({int limit = 20, int offset = 0}) =>
      SpeechesListParams(
          searchQuery: searchQuery,
          easyFilter: easyFilterValue,
          limit: limit,
          offset: offset,
          sortingParam: sortingParam,
          to: to,
          from: from
      );
}

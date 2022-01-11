import 'package:project_athens/athens_core/ads/domain/ads_facade.dart';
import 'package:project_athens/athens_core/domain/base_list/items_repository.dart';
import 'package:project_athens/athens_core/domain/base_list/list_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/easy_filters/easy_filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filters_facade.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/deputies_flow/domain/deputies_list_params.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputies_easy_filter.dart';

class DeputiesListFacade extends ListFacade<DeputiesListParams>
    with SearchAppBarFacade, EasyFiltersFacade<DeputiesEasyFilter>, AdsFacade<DeputiesListParams> {
  DeputiesListFacade(
      ItemsRepository itemsRepository, this.easyFiltersRepository)
      : super(itemsRepository);

  @override
  final EasyFiltersRepository<DeputiesEasyFilter> easyFiltersRepository;

  @override
  DeputiesListParams getParams({int limit = 20, int offset = 0}) =>
      DeputiesListParams(
        searchQuery: searchQuery,
        easyFilter: easyFilterValue
      );
}

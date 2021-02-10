import 'package:project_athens/athens_core/domain/list/base_model.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/items_repository.dart';
import 'package:project_athens/athens_core/domain/list/list_facade.dart';
import 'package:project_athens/athens_core/filters_and_sort/data/filters_repository.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/filterable_facade.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';

class BaseListFacade<MODEL extends BaseModel>
    extends ListFacade<MODEL, BaseListParams> with FilterableFacade, SearchAppBarFacade {

  BaseListFacade(
      ItemsRepository<MODEL, BaseListParams> itemsRepository,
      FiltersRepository filtersRepository
      ) : super(itemsRepository) {
    this.filtersRepository = filtersRepository;
  }


  @override
  BaseListParams getParams({int limit = 20, int offset = 0}) => BaseListParams(
    searchQuery: searchQuery,
    from: from,
    to: to,
    limit: limit,
    offset: offset,
    sortingParam: sortingParam
  );

}

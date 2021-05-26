import 'package:project_athens/athens_core/domain/base_list/items_repository.dart';
import 'package:project_athens/athens_core/domain/base_list/list_facade.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/deputies_flow/domain/deputies_list_params.dart';

class DeputiesListFacade extends ListFacade<DeputiesListParams> with SearchAppBarFacade {
  DeputiesListFacade(ItemsRepository itemsRepository) : super(itemsRepository);

  @override
  DeputiesListParams getParams({int limit = 20, int offset = 0}) => DeputiesListParams(
    searchQuery
  );
}
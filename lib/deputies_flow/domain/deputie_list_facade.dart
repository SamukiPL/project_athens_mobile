import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/items_repository.dart';
import 'package:project_athens/athens_core/domain/list/list_facade.dart';
import 'package:project_athens/athens_core/presentation/search_app_bar/search_app_bar_facade.dart';
import 'package:project_athens/deputies_flow/domain/deputies_list_params.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';

class DeputiesListFacade extends ListFacade<DeputyModel, DeputiesListParams> with SearchAppBarFacade {
  DeputiesListFacade(ItemsRepository<DeputyModel, DeputiesListParams> itemsRepository) : super(itemsRepository);

  @override
  DeputiesListParams getParams({int limit = 20, int offset = 0}) => DeputiesListParams(
    searchQuery
  );

}
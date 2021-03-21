import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/base_list/items_repository.dart';
import 'package:project_athens/athens_core/domain/result.dart';

abstract class ListFacade<PARAMS extends BaseParams> {

  final ItemsRepository _itemsRepository;

  ListFacade(this._itemsRepository);

  Future<void> fetchItems(int limit, int offset) {
    return _itemsRepository.fetchItems(getParams(limit: limit, offset: offset));
  }

  Stream<Result<List<BaseModel>>> getItems() {
    return _itemsRepository.getItems(getParams());
  }

  Future<void> refreshItems() {
    return _itemsRepository.refreshItems(getParams());
  }

  PARAMS getParams({int limit = 20, int offset = 0});

  void dispose() {
    _itemsRepository.dispose();
  }

}
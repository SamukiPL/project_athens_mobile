import 'package:project_athens/athens_core/domain/list/base_model.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/items_repository.dart';
import 'package:project_athens/athens_core/domain/result.dart';

class ListUseCase<MODEL extends BaseModel, PARAMS extends BaseParams> {

  final ItemsRepository<MODEL, PARAMS> _itemsRepository;

  ListUseCase(this._itemsRepository);

  Future<void> fetchItems(int limit, int offset) {
    return _itemsRepository.fetchItems(limit, offset);
  }

  Stream<Result<List<MODEL>>> getItems(PARAMS params) {
    return _itemsRepository.getItems(params);
  }

  Future<void> refreshItems() {
    return _itemsRepository.refreshItems();
  }

}
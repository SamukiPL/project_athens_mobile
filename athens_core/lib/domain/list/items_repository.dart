import 'package:athens_core/domain/list/base_model.dart';
import 'package:athens_core/domain/list/base_params.dart';
import 'package:athens_core/domain/result.dart';
import 'package:rxdart/rxdart.dart';

abstract class ItemsRepository<MODEL extends BaseModel, PARAMS extends BaseParams> {

  Future<void> fetchItems(int limit, int offset);

  PublishSubject<Result<List<MODEL>>> getItems(PARAMS params);

  Future<void> refreshItems();

}
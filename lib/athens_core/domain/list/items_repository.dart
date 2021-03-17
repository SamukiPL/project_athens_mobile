import 'package:project_athens/athens_core/domain/list/base_model.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:rxdart/rxdart.dart';

abstract class ItemsRepository<MODEL extends BaseModel, PARAMS extends BaseParams> {

  Future<void> fetchItems(PARAMS params);

  Stream<Result<List<MODEL>>> getItems(PARAMS params);

  Future<void> refreshItems(PARAMS params);

  void dispose();

}
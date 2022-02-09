import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';

abstract class ItemsRepository {

  Future<void> fetchItems(BaseParams params);

  Stream<Result<List<BaseModel>>> getItems(BaseParams params);

  Future<void> refreshItems(BaseParams params);

  void dispose();

}

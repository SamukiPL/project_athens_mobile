import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/base_list/list_facade.dart';
import 'package:project_athens/athens_core/domain/result.dart';

abstract class NetworkListDataSource<MODEL extends BaseModel, PARAMS extends BaseParams> {

  Future<Result<List<MODEL>>> call(PARAMS params);

}
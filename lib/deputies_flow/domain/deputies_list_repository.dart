import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/items_repository.dart';
import 'package:project_athens/deputies_flow/domain/deputies_list_params.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';

abstract class DeputiesListRepository extends ItemsRepository<DeputyModel, DeputiesListParams> {

}
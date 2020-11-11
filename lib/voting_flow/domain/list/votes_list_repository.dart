import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/list/items_repository.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';

abstract class VotesListRepository extends ItemsRepository<VotingModel, BaseParams> {}
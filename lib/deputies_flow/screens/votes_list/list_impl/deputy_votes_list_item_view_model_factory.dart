import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/item_view_model_factory.dart';
import 'package:project_athens/deputies_flow/screens/votes_list/list_impl/deputy_votes_list_item_view_model.dart';

class DeputyVotesListItemViewModelFactory extends ItemViewModelFactory {
  @override
  BaseItemViewModel? createWithoutError(BaseModel model) {
    if (model is VoteSlimModel) {
      return DeputyVotesListItemViewModel(model);
    }
    return null;
  }
}

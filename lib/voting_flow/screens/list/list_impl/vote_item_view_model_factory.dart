import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/item_view_model_factory.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model.dart';

class VoteItemViewModelFactory extends ItemViewModelFactory {
  @override
  BaseItemViewModel? createWithoutError(BaseModel model) {
    if (model is VoteSlimModel) {
      return VoteItemViewModel(model);
    }

    return null;
  }
}

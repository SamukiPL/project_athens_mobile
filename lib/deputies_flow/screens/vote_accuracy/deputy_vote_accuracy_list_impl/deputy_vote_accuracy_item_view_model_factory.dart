import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/item_view_model_factory.dart';

import 'deputy_vote_accuracy_item_view_model.dart';

class DeputyVoteAccuracyItemViewModelFactory extends ItemViewModelFactory {

  @override
  BaseItemViewModel? createWithoutError(BaseModel model) {
    switch (model.runtimeType) {
      case VoteSlimModel:
        return DeputyVoteAccuracyItemViewModel(model as VoteSlimModel);
        break;
    }

    return null;
  }

}
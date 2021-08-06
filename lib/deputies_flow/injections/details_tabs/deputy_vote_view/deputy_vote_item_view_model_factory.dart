import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/item_view_model_factory.dart';
import 'package:project_athens/deputies_flow/injections/details_tabs/deputy_vote_view/deputy_vote_item_view_model.dart';

class DeputyVoteItemViewModelFactory extends ItemViewModelFactory {

  @override
  BaseItemViewModel? createWithoutError(BaseModel model) {
    switch (model.runtimeType) {
      case VotingModel:
        return DeputyVoteItemViewModel(model as VotingModel);
    }

    return null;
  }

}
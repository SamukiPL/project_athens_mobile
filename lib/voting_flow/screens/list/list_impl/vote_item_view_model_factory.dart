import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model.dart';

class VoteItemViewModelFactory extends DataMapper<VotingModel, VoteItemViewModel> {
  @override
  VoteItemViewModel transform(VotingModel data) => VoteItemViewModel();

}
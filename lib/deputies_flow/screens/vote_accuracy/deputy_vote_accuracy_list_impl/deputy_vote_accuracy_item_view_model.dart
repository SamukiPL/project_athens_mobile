import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/utils/get_vote_description_helper.dart';
import 'package:project_athens/deputies_flow/domain/vote_slim_majority_model.dart';
import 'package:project_athens/deputies_flow/screens/vote_accuracy/deputy_vote_accuracy_list_impl/view_holders/deputy_vote_accuracy_view_holder.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/view_holders/vote_view_holder.dart';

class DeputyVoteAccuracyItemViewModel extends BaseItemViewModel {

  final VoteSlimModel model;

  String get id => model.id;
  String get title => model.title != null ? model.title : "";
  String get date => DateFormat("d.MM.y", "pl").format(model.voteAt);
  VoteNumbers get results => model.voteNumbers;
  String get description => model.votingDesc;
  List<VoteSlimClubMajority>? get clubs => model.clubsMajority;
  List<VoteSlimDeputyVoteType>? get deputies => model.deputiesVote;

  DeputyVoteAccuracyItemViewModel(this.model);

  @override
  Widget buildWidget(int index, int length) => DeputyVoteAccuracyViewHolder(this);

}
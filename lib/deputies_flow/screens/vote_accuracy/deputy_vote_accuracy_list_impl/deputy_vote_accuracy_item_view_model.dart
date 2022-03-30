import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/deputies_flow/screens/vote_accuracy/deputy_vote_accuracy_list_impl/view_holders/deputy_vote_accuracy_view_holder.dart';

class DeputyVoteAccuracyItemViewModel extends BaseItemViewModel {
  final VoteSlimModel model;

  String get id => model.id;
  String get title => model.title != null ? model.title : "";
  String get date => DateFormat("dd.MM.y", "pl").format(model.voteAt);
  VoteNumbers get results => model.voteNumbers;
  String get description => model.votingDesc;
  List<VoteSlimClubMajority>? get clubs => model.clubsMajority;
  List<VoteSlimDeputyVoteType>? get deputies => model.deputiesVote;

  DeputyVoteAccuracyItemViewModel(this.model);

  @override
  Widget buildWidget(int index, int length) => DeputyVoteAccuracyViewHolder(this);
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/item_was_seen/item_seen_state_holder.dart';
import 'package:project_athens/deputies_flow/screens/votes_list/list_impl/view_holders/deputy_votes_list_view_holder.dart';

class DeputyVotesListItemViewModel extends BaseItemViewModel with ItemSeenStateHolder {
  final VoteSlimModel model;

  String get id => model.id;
  String get title => model.title;
  String get date => DateFormat("dd.MM.y", "pl").format(model.voteAt);
  String get description => model.votingDesc;
  VoteType? get deputyVoteType => model.deputyVoteType;

  DeputyVotesListItemViewModel(this.model);

  @override
  bool startViewedValue() => model.viewed;

  @override
  Widget buildWidget(int index, int length) {
    return DeputyVotesListViewHolder(this);
  }

  Color getVoteIconColor(ThemeData theme, VoteType checkAgainst) {
    return deputyVoteType == checkAgainst ? theme.primaryColor : theme.dividerColor;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/item_was_seen/item_seen_state_holder.dart';
import 'package:project_athens/deputies_flow/injections/details_tabs/deputy_vote_view/view_holder/deputy_vote_view_holder.dart';

class DeputyVoteItemViewModel extends BaseItemViewModel with ItemSeenStateHolder {

  final VotingModel model;

  String get id => model.id;
  String get title => model.title;
  String get date => DateFormat("d.MM.y", "pl").format(model.date);
  VoteResultModel get results => model.results;
  String get description => model.votingDesc;
  VoteType? get deputyVoteType  => model.deputyVoteType;

  DeputyVoteItemViewModel(this.model);

  @override
  bool startViewedValue() => model.viewed;

  @override
  Widget buildWidget(int index, int length) => DeputyVoteViewHolder(this);

  Color getVoteIconColor(ThemeData theme, VoteType checkAgainst) {
    return deputyVoteType == checkAgainst ? theme.primaryColor : theme.dividerColor;
  }
}

import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destinations.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/grouped_voting_view_holder.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/speech_view_holder.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/voting_view_holder.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';

bool showTopLine(int index) => index != 0;
bool showBottomLine(int index, int length) => index != length - 1;

class VotingRowViewModel extends BaseItemViewModel {

  final VotingModel model;

  VotingRowViewModel(this.model);

  @override
  Widget buildWidget(int index, int length) {
    return VotingViewHolder(this, showTopLine(index), showBottomLine(index, length));
  }

}

class SpeechRowViewModel extends BaseItemViewModel {

  final SpeechModel model;

  SpeechRowViewModel(this.model);

  @override
  Widget buildWidget(int index, int length) {
    return SpeechViewHolder(this, showTopLine(index), showBottomLine(index, length));
  }

}

class GroupedVotingViewModel extends BaseItemViewModel {

  final GroupedVotingModel model;

  GroupedVotingViewModel(this.model);

  @override
  Widget buildWidget(int index, int length) {
    return GroupedVotingViewHolder(this, showTopLine(index), showBottomLine(index, length));
  }

}
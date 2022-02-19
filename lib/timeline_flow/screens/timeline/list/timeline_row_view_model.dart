import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/timeline_voting_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/item_was_seen/item_seen_state_holder.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/ad_timeline_view_holder.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/grouped_voting_view_holder.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/speech_view_holder.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/timer_view_holder.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/voting_view_holder.dart';

bool showTopLine(int index) => index != 0;
bool showBottomLine(int index, int length) => index != length - 1;

class VotingRowViewModel extends BaseItemViewModel with ItemSeenStateHolder {

  final TimelineVotingModel model;
  final bool firstLevel;

  VotingRowViewModel(this.model, this.firstLevel);

  @override
  Widget buildWidget(int index, int length) {
    return VotingViewHolder(this, showTopLine(index), showBottomLine(index, length), firstLevel: firstLevel);
  }

  @override
  bool startViewedValue() => model.viewed;
}

class SpeechRowViewModel extends BaseItemViewModel with ItemSeenStateHolder {

  final SpeechModel model;

  SpeechRowViewModel(this.model);

  @override
  Widget buildWidget(int index, int length) {
    return SpeechViewHolder(this, showTopLine(index), showBottomLine(index, length));
  }

  @override
  bool startViewedValue() => model.viewed;

}

class GroupedVotingViewModel extends BaseItemViewModel with ItemSeenStateHolder {

  final GroupedVotingModel model;

  GroupedVotingViewModel(this.model);

  @override
  Widget buildWidget(int index, int length) {
    return GroupedVotingViewHolder(this, showTopLine(index), showBottomLine(index, length));
  }

  @override
  bool startViewedValue() => model.groupedVotes.every((element) => element.viewed);

}

class TimerViewModel extends BaseItemViewModel {

  final VoidCallback refresh;

  TimerViewModel(this.refresh);

  @override
  Widget buildWidget(int index, int length) {
    return TimerViewHolder(this, showTopLine(index), showBottomLine(index, length));
  }

}

class AdTimelineViewModel extends BaseItemViewModel {

  @override
  Widget buildWidget(int index, int length) {
    return AdTimelineViewHolder(showTopLine(index), showBottomLine(index, length));
  }

}

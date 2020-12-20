import 'package:flutter/material.dart';
import 'package:project_athens/pagination/paging_list.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/grouped_voting_view_holder.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/progress_view_holder.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/speech_view_holder.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/voting_view_holder.dart';

class TimelineList extends PagingList<TimelineRowViewModel> {
  TimelineList(PagingListAdapter<TimelineRowViewModel> adapter)
      : super(adapter);

  @override
  double get bottomPadding => 72;

  @override
  StatelessWidget getItemViewHolder(
      TimelineRowViewModel item, int index, int length) {
    final showTopLine = index != 0;
    final showBottomLine = index != length - 1;
    switch (item.type) {
      case TimelineModelType.VOTING:
        return VotingViewHolder(item, showTopLine, showBottomLine);
        break;
      case TimelineModelType.SPEECH:
        return SpeechViewHolder(item, showTopLine, showBottomLine);
        break;
      case TimelineModelType.GROUPED_VOTING:
        return GroupedVotingViewHolder(item, showTopLine, showBottomLine);
        break;
      default:
        throw ArgumentError("There is no more TimelineModelType");
    }
  }

  @override
  StatelessWidget get progressView => ProgressViewHolder();
}

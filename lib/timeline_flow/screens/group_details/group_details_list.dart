import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/presentation/stateless_list_widget.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/view_holders/voting_view_holder.dart';

class GroupDetailsList extends StatelessListWidget<TimelineRowViewModel> {

  GroupDetailsList(List<TimelineRowViewModel> items) : super(items);

  @override
  StatelessWidget getItemViewHolder(TimelineRowViewModel item, int index, int length) {
    final showTopLine = index != 0;
    final showBottomLine = index != length - 1;
    return VotingViewHolder(item, showTopLine, showBottomLine);
  }

}
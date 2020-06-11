import 'package:flutter/material.dart';
import 'package:project_athens/pagination/paging_list.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';
import 'package:project_athens/timeline_flow/screens/list/timeline_row_view_model.dart';
import 'package:project_athens/timeline_flow/screens/list/view_holders/progress_view_holder.dart';
import 'package:project_athens/timeline_flow/screens/list/view_holders/timeline_view_holder.dart';

class TimelineList extends PagingList<TimelineRowViewModel> {
  TimelineList(PagingListAdapter<TimelineRowViewModel> adapter)
      : super(adapter);

  @override
  StatelessWidget getItemViewHolder(
          TimelineRowViewModel item, int index, int length) =>
      TimelineViewHolder(item, index != 0, index != length - 1);

  @override
  StatelessWidget get progressView => ProgressViewHolder();
}

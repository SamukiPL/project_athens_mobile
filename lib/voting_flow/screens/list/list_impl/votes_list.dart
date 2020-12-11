import 'package:flutter/material.dart';
import 'package:project_athens/pagination/paging_list.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/view_holders/vote_progress_view_holder.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/view_holders/vote_view_holder.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model.dart';

class VotesList extends PagingList<VoteItemViewModel> {

  VotesList(PagingListAdapter<VoteItemViewModel> adapter, String noDataText) : super(adapter, noDataText: noDataText);

  @override
  bool get refreshable => false;

  @override
  StatelessWidget getItemViewHolder(VoteItemViewModel item, int index, int length) {
    return VoteViewHolder(item);
  }

  @override
  StatelessWidget get progressView => VoteProgressViewHolder();

  @override
  StatelessWidget buildSeparator(context, index) => Divider(
    height: 1,
    indent: 58,
  );

}
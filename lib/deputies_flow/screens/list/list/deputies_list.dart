import 'package:flutter/material.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/deputy_item_view_model.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/view_holders/deputy_view_holder.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/view_holders/progress_view_holder.dart';
import 'package:project_athens/deputies_flow/screens/list/list/view_holders/deputy_list_view_holder.dart';
import 'package:project_athens/pagination/paging_list.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';

import 'deputy_list_item_view_model.dart';

class DeputiesList extends PagingList<DeputyListItemViewModel> {
  @override
  bool get refreshable => false;

  DeputiesList(PagingListAdapter<DeputyListItemViewModel> adapter) : super(adapter);

  @override
  StatelessWidget get progressView => ProgressViewHolder();

  @override
  StatelessWidget getItemViewHolder(DeputyListItemViewModel item, int index, int length) {
    return DeputyListViewHolder(viewModel: item);
  }
}

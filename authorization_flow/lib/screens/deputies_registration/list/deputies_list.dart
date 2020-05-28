import 'package:authorization_flow/screens/deputies_registration/list/deputy_item_view_model.dart';
import 'package:authorization_flow/screens/deputies_registration/list/view_holders/deputy_view_holder.dart';
import 'package:authorization_flow/screens/deputies_registration/list/view_holders/progress_view_holder.dart';
import 'package:flutter/material.dart';
import 'package:pagination/paging_list.dart';
import 'package:pagination/paging_list_adapter.dart';

class DeputiesList extends PagingList<DeputyItemViewModel> {
  DeputiesList(PagingListAdapter<DeputyItemViewModel> adapter) : super(adapter);

  @override
  StatelessWidget get progressView => ProgressViewHolder();

  @override
  StatelessWidget getItemViewHolder(DeputyItemViewModel item, int index, int length) {
    return DeputyViewHolder(viewModel: item);
  }
}

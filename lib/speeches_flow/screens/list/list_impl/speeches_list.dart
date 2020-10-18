import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/pagination/paging_list.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speech_item_view_model.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/view_holders/progress_view_holder.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/view_holders/speech_view_holder.dart';

class SpeechesList extends PagingList<SpeechItemViewModel> {

  SpeechesList(PagingListAdapter<SpeechItemViewModel> adapter) : super(adapter);

  @override
  StatelessWidget getItemViewHolder(SpeechItemViewModel item, int index, int length) {
    return SpeechViewHolder(item);
  }

  @override
  StatelessWidget get progressView => ProgressViewHolder();

  @override
  StatelessWidget buildSeparator(context, index) => Divider(
    height: 1,
    indent: 58,
  );

}
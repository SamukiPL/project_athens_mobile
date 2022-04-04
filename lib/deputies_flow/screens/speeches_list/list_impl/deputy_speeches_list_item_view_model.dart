import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/item_was_seen/item_seen_state_holder.dart';
import 'package:project_athens/deputies_flow/screens/speeches_list/list_impl/view_holders/deputy_speeches_list_view_holder.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class DeputySpeechListItemViewModel extends BaseItemViewModel
    with ItemSeenStateHolder {
  final SpeechModel model;

  DeputySpeechListItemViewModel(this.model);

  @override
  bool startViewedValue() => model.viewed;

  @override
  Widget buildWidget(int index, int length) {
    return DeputySpeechListViewHolder(this);
  }
}

import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/view_holders/speech_view_holder.dart';

class SpeechItemViewModel extends BaseItemViewModel {

  final SpeechModel model;

  SpeechItemViewModel(this.model);

  @override
  Widget buildWidget(int index, int length) {
    return SpeechViewHolder(this);
  }

}
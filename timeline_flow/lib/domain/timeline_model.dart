import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TimelineModel {
  final String id;
  final TimelineModelType type;
  final String title;
  final String desc;
  final DateTime date;

  TimelineModel(this.id, this.type, this.title, this.desc, this.date);

  factory TimelineModel.getVoting(
          String id, String title, DateTime speechDate) =>
      TimelineModel(id, TimelineModelType.VOTING, title, null, speechDate);

  factory TimelineModel.getSpeech(
          String id, String title, String desc, DateTime speechDate) =>
      TimelineModel(id, TimelineModelType.SPEECH, title, desc, speechDate);
}

enum TimelineModelType { VOTING, SPEECH }

extension TimelineModelTypeExt on TimelineModelType {

  IconData getIconForType() {
    switch (this) {
      case TimelineModelType.VOTING:
        return MdiIcons.vote;
        break;
      default:
        return Icons.record_voice_over;
        break;
    }
  }

}

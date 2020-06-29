import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

abstract class TimelineModel {

  final String id;
  final TimelineModelType type;
  final String title;
  final DateTime date;

  TimelineModel(this.id, this.type, this.title, this.date);

}

class VotingModel extends TimelineModel {
  VotingModel(String id, String title, DateTime date) : super(id, TimelineModelType.VOTING, title, date);
}

class SpeechModel extends TimelineModel{
  final String desc;
  final Future<String> thumbnailUrl;

  SpeechModel(String id, String title, this.desc, DateTime date, this.thumbnailUrl) : super(id, TimelineModelType.SPEECH, title, date);
}

enum TimelineModelType { VOTING, SPEECH }

//extension TimelineModelTypeExt on TimelineModel {
//
//  IconData getIconForType() {
//    switch (this) {
//      case TimelineModelType.VOTING:
//        return MdiIcons.vote;
//        break;
//      default:
//        return Icons.record_voice_over;
//        break;
//    }
//  }
//
//}

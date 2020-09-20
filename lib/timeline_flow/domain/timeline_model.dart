import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/domain/list/base_model.dart';

abstract class TimelineModel extends BaseModel {

  final String id;
  final TimelineModelType type;
  final String title;
  final DateTime date;

  TimelineModel(this.id, this.type, this.title, this.date);

}

class VotingModel extends TimelineModel {
  VotingModel(
      String id,
      String title,
      DateTime date
      ) : super(id, TimelineModelType.VOTING, title, date);
}

class SpeechModel extends TimelineModel{
  final String club;
  final String desc;
  final Future<String> thumbnailUrl;
  final String videoUrl;

  SpeechModel(
      String id,
      String title,
      this.club,
      this.desc,
      DateTime date,
      this.thumbnailUrl,
      this.videoUrl
      ) : super(id, TimelineModelType.SPEECH, title, date);
}

enum TimelineModelType { VOTING, SPEECH }

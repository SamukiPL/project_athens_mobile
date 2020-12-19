import 'dart:developer';

import 'package:project_athens/athens_core/domain/list/base_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';

abstract class TimelineModel extends BaseModel {

  final String id;
  final TimelineModelType type;
  final DateTime date;

  TimelineModel(this.id, this.type, this.date);

}

class SpeechModel extends TimelineModel {
  final String personName;
  final String deputyId;
  final String club;
  final String desc;
  final String thumbnailUrl;
  final String videoUrl;

  SpeechModel({
    String id,
    this.personName,
    this.deputyId,
    this.club,
    this.desc,
    DateTime date,
    this.thumbnailUrl,
    this.videoUrl
  }) : super(id, TimelineModelType.SPEECH, date);
}

class GroupedVotingModel extends TimelineModel {
  final String votingDesc;
  final String title;
  final List<VotingModel> groupedVotes;
  final DateTime firstDate;
  final DateTime lastDate;

  GroupedVotingModel({
    this.votingDesc,
    this.title,
    this.groupedVotes,
    this.firstDate,
    this.lastDate,
    String id,
    DateTime date
  }) : super(id, TimelineModelType.GROUPED_VOTING, date);

}

enum TimelineModelType { VOTING, GROUPED_VOTING, SPEECH }

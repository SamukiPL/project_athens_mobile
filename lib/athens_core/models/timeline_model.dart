import 'package:project_athens/athens_core/domain/list/base_model.dart';

abstract class TimelineModel extends BaseModel {

  final String id;
  final TimelineModelType type;
  final DateTime date;

  TimelineModel(this.id, this.type, this.date);

}

class VotingModel extends TimelineModel {
  final String votingDesc;
  final String title;

  VotingModel({
    String id,
    this.title,
    DateTime date,
    this.votingDesc
  }) : super(id, TimelineModelType.VOTING, date);
}

class SpeechModel extends TimelineModel{
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

enum TimelineModelType { VOTING, SPEECH }

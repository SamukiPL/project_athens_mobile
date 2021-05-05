import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class SpeechModel extends TimelineModel {
  final String personName;
  final String deputyId;
  final ParliamentClubModel club;
  final String desc;
  final String thumbnailUrl;
  final String videoUrl;
  final PersonSpeechModel nextPersonSpeech;
  final PersonSpeechModel previousPersonSpeech;

  SpeechModel({
    String id,
    this.personName,
    this.deputyId,
    this.club,
    this.desc,
    DateTime date,
    this.thumbnailUrl,
    this.videoUrl,
    this.nextPersonSpeech,
    this.previousPersonSpeech,
  }) : super(id, TimelineModelType.SPEECH, date);

  SpeechModel changePersonSpeeches({PersonSpeechModel newNextPersonSpeech, PersonSpeechModel newPreviousPersonSpeech}) => SpeechModel(
    id: id,
    personName: personName,
    deputyId: deputyId,
    club: club,
    desc: desc,
    date: date,
    thumbnailUrl: thumbnailUrl,
    videoUrl: videoUrl,
    nextPersonSpeech: newNextPersonSpeech,
    previousPersonSpeech: newPreviousPersonSpeech
  );
}

class PersonSpeechModel {
  final String name;
  final String thumbnailUrl;
  final String speechId;

  PersonSpeechModel({this.name, this.thumbnailUrl, this.speechId});
}

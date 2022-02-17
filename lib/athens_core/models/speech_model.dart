import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class SpeechModel extends TimelineModel {
  final String personName;
  final String? deputyId;
  final ParliamentClubModel? club;
  final String? desc;
  final String? thumbnailUrl;
  final String videoUrl;
  final PersonSpeechModel? nextPersonSpeech;
  final PersonSpeechModel? previousPersonSpeech;
  final bool viewed;

  SpeechModel({
    required String id,
    required this.personName,
    this.deputyId,
    this.club,
    this.desc,
    required DateTime date,
    this.thumbnailUrl,
    required this.videoUrl,
    this.nextPersonSpeech,
    this.previousPersonSpeech,
    this.viewed = false,
    DateTime? createAt,
    DateTime? updateAt,
  }) : super(id, TimelineModelType.SPEECH, date, createAt, updateAt);

  SpeechModel changePersonSpeeches(
          {PersonSpeechModel? newNextPersonSpeech,
          PersonSpeechModel? newPreviousPersonSpeech}) =>
      SpeechModel(
          id: id,
          personName: personName,
          deputyId: deputyId,
          club: club,
          desc: desc,
          date: date,
          thumbnailUrl: thumbnailUrl,
          videoUrl: videoUrl,
          nextPersonSpeech: newNextPersonSpeech,
          previousPersonSpeech: newPreviousPersonSpeech,
          updateAt: updateAt,
          createAt: createAt);
}

class PersonSpeechModel {
  final String? name;
  final String? thumbnailUrl;
  final String speechId;

  PersonSpeechModel({required this.name, this.thumbnailUrl, required this.speechId});
}

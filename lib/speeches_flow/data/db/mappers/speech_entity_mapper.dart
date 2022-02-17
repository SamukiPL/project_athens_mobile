import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/ext/db_value_extension.dart';

class SpeechEntityMapper
    extends DataMapper<SpeechResponse, SpeechEntityCompanion> {
  @override
  SpeechEntityCompanion transform(SpeechResponse data) {
    return SpeechEntityCompanion.insert(
        id: data.id,
        personName: data.personName,
        deputyId: ValueExt.absentIfNull(data.cadencyDeputy),
        clubId: ValueExt.absentIfNull(data.parliamentClub),
        desc: ValueExt.absentIfNull(data.agenda?.title),
        date: data.cisInfo.eventDateTime,
        videoUrl: data.videoDownloadUrl,
        createAt: data.createAt,
        updateAt: data.updateAt,
        nextDeputyCardId: ValueExt.absentIfNull(data.nextPersonSpeech?.deputyCardId),
        nextName: ValueExt.absentIfNull(data.nextPersonSpeech?.fullName),
        nextSpeechId: ValueExt.absentIfNull(data.nextPersonSpeech?.speechId),
        previousDeputyCardId: ValueExt.absentIfNull(data.previousPersonSpeech?.deputyCardId),
        previousName: ValueExt.absentIfNull(data.previousPersonSpeech?.fullName),
        previousSpeechId: ValueExt.absentIfNull(data.previousPersonSpeech?.speechId),
        viewed: data.viewed == true);
  }
}

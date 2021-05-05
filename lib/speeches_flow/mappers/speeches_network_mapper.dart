import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';

class SpeechesNetworkMapper
    extends AsyncDataMapper<SpeechResponse, SpeechModel> {
  final DeputiesCache _deputiesCache;

  SpeechesNetworkMapper(this._deputiesCache);

  @override
  Future<SpeechModel> transform(SpeechResponse data) async {
    return SpeechModel(
        id: data.id,
        personName: data.personName,
        deputyId: data.cadencyDeputy,
        club: await _deputiesCache.getParliamentClubModel(data.parliamentClub),
        desc: data.agenda?.title,
        date: data.cisInfo.eventDateTime,
        thumbnailUrl: await _deputiesCache.getDeputyThumbnail(data.cadencyDeputy) ?? "",
        videoUrl: data.videoDownloadUrl,
        nextPersonSpeech: await _transformPersonSpeechResponse(data.nextPersonSpeech),
        previousPersonSpeech: await _transformPersonSpeechResponse(data.previousPersonSpeech),
    );
  }

  Future<PersonSpeechModel> _transformPersonSpeechResponse(PersonSpeech personSpeech) async {
    if (personSpeech == null) return null;

    if (personSpeech.deputyCardId != null) {
      final deputy = await _deputiesCache.getDeputyModelByCardId(personSpeech.deputyCardId);

      return PersonSpeechModel(name: deputy.name, thumbnailUrl: deputy.thumbnailUrl, speechId: personSpeech.speechId);
    }

    return PersonSpeechModel(name: personSpeech.fullName, speechId: personSpeech.speechId);
  }
}

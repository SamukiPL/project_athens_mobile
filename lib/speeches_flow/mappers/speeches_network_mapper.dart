import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';

class SpeechesNetworkMapper
    extends AsyncDataMapper<SpeechResponse, SpeechModel> {
  final DeputiesCache _deputiesCache;
  final ParliamentClubsCache _clubsCache;

  SpeechesNetworkMapper(this._deputiesCache, this._clubsCache);

  @override
  Future<SpeechModel> transform(SpeechResponse data) async {
    final String? thumbnailUrl = data.cadencyDeputy != null ? await _deputiesCache.getDeputyThumbnail(data.cadencyDeputy!) : null;

    return SpeechModel(
        id: data.id,
        personName: data.personName,
        deputyId: data.cadencyDeputy,
        club: await _clubsCache.getParliamentClubModel(data.parliamentClub),
        desc: data.agenda?.title,
        date: data.cisInfo.eventDateTime,
        thumbnailUrl: thumbnailUrl,
        videoUrl: data.videoDownloadUrl,
        nextPersonSpeech: await _transformPersonSpeechResponse(data.nextPersonSpeech),
        previousPersonSpeech: await _transformPersonSpeechResponse(data.previousPersonSpeech),
        viewed: data.viewed == true,
        createAt: data.createAt,
        updateAt: data.updateAt
    );
  }

  Future<PersonSpeechModel?> _transformPersonSpeechResponse(PersonSpeech? personSpeech) async {
    if (personSpeech == null || personSpeech!.speechId == null) return null;

    if (personSpeech.deputyCardId != null) {
      final deputy = await _deputiesCache.getDeputyModelByCardId(personSpeech.deputyCardId!);

      return PersonSpeechModel(name: deputy.name, thumbnailUrl: deputy.thumbnailUrl, speechId: personSpeech.speechId!);
    }

    return PersonSpeechModel(name: personSpeech.fullName, speechId: personSpeech.speechId!);
  }
}

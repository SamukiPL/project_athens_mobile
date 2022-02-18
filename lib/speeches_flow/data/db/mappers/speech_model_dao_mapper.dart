import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';

class SpeechModelDaoMapper extends AsyncDataMapper<SpeechEntityData, SpeechModel> {
  final DeputiesCache _deputiesCache;
  final ParliamentClubsCache _clubsCache;

  SpeechModelDaoMapper(this._deputiesCache, this._clubsCache);

  @override
  Future<SpeechModel> transform(SpeechEntityData data) async {
    final String? thumbnailUrl = data.deputyId != null ? await _deputiesCache.getDeputyThumbnail(data.deputyId!) : null;
    return SpeechModel(
        id: data.id,
        personName: data.personName,
        deputyId: data.deputyId,
        club: await _clubsCache.getParliamentClubModel(data.clubId),
        desc: data.desc,
        date: data.date,
        thumbnailUrl: thumbnailUrl,
        videoUrl: data.videoUrl,
        nextPersonSpeech: await _transformPersonSpeechResponse(data.nextSpeechId, data.nextSpeechId, data.nextDeputyCardId),
        previousPersonSpeech: await _transformPersonSpeechResponse(data.previousName, data.previousSpeechId, data.previousDeputyCardId),
        createAt: data.createAt,
        updateAt: data.updateAt,
        viewed: data.viewed
    );
  }

  Future<PersonSpeechModel?> _transformPersonSpeechResponse(String? name, String? speechId, int? deputyCard) async {
    if (name == null) return null;
    if (deputyCard != null) {
      final deputy = await _deputiesCache.getDeputyModelByCardId(deputyCard);
      return PersonSpeechModel(name: deputy.name, thumbnailUrl: deputy.thumbnailUrl, speechId: speechId!);
    }

    return PersonSpeechModel(name: name, speechId: speechId!);
  }
}
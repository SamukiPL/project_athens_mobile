import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/speeches_flow/data/network/responses/speech_response.dart';

class SpeechesNetworkMapper
    extends AsyncDataMapper<SpeechResponse, SpeechModel> {
  final DeputiesCache _deputiesCache;

  SpeechesNetworkMapper(this._deputiesCache);

  @override
  Future<SpeechModel> transform(SpeechResponse data) async {
    return SpeechModel(
        data.id,
        data.personName,
        data.parliamentClub,
        data.agenda?.title,
        data.cisInfo.eventDateTime,
        await _deputiesCache.getDeputyThumbnail(data.cadencyDeputy),
        data.videoDownloadUrl);
  }
}

import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/speeches_flow/data/network/speeches_api.dart';
import 'package:project_athens/speeches_flow/data/speech_cache.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';

class DetailsSpeechNetworkDataSource {

  final SpeechesApi _speechesApi;
  final SpeechesNetworkMapper _networkMapper;

  final String _speechId;
  final bool _isNormalSpeech;
  final SpeechCache _speechCache;

  DetailsSpeechNetworkDataSource(this._speechesApi, this._networkMapper, this._speechId, this._isNormalSpeech, this._speechCache);

  Future<Result<SpeechModel>> call() async {
    if (_speechCache.hasSpeech(_speechId, _isNormalSpeech)) {
      return Success(_speechCache.getSpeech(_speechId, _isNormalSpeech));
    }

    final response = await _speechesApi.getSpeech(_speechId);
    final model = await _networkMapper.transform(response);

    _speechCache.saveSpeech(model);

    return Success(model);
  }
}

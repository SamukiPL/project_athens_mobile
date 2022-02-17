import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/speeches_flow/data/network/request/speech_search_request.dart';
import 'package:project_athens/speeches_flow/data/network/speeches_api.dart';
import 'package:project_athens/speeches_flow/data/speech_cache.dart';
import 'package:project_athens/speeches_flow/data/speeches_list_local_data_source.dart';
import 'package:project_athens/speeches_flow/domain/speeches_list_params.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';

class SpeechesListNetworkDataSource
    extends NetworkListDataSource<SpeechModel, SpeechesListParams> {
  final SpeechesApi _speechesApi;
  final SpeechesNetworkMapper _networkMapper;

  final SpeechCache _speechCache;

  final SpeechesListLocalDataSource _localDataSource;

  SpeechesListNetworkDataSource(this._speechesApi, this._networkMapper,
      this._speechCache, this._localDataSource);

  @override
  Future<Result<List<SpeechModel>>> call(SpeechesListParams params) async {
    try {
      if (params.easyFilter != null) {
        return Success(await _localDataSource.getSpeechModels(
            params.limit, params.offset, params.easyFilter!));
      }
      final response = await _speechesApi.getSpeeches(SpeechSearchRequest(
          params.limit,
          params.offset,
          params.searchQuery,
          params.from?.toIso8601String(),
          params.to?.toIso8601String(),
          params.sortingParam));

      final modelsList = await _networkMapper(response.speeches);
      _speechCache.saveSpeeches(modelsList);
      _localDataSource.saveSpeechModels(response.speeches);

      return Success(modelsList);
    } catch (error) {
      return Failure(error);
    }
  }
}

import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/deputies_flow/data/network/deputies_details_api.dart';
import 'package:project_athens/deputies_flow/data/speeches/deputy_speeches_local_data_source.dart';
import 'package:project_athens/deputies_flow/domain/speeches/deputy_speeches_list_params.dart';
import 'package:project_athens/speeches_flow/data/network/request/speech_search_request.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';

class DeputySpeechesNetworkDataSource extends NetworkListDataSource<SpeechModel, DeputySpeechesListParams> {
  final DeputiesDetailsApi _deputiesDetailsApi;
  final SpeechesNetworkMapper _networkMapper;
  final DeputySpeechesListLocalDataSource _localDataSource;

  final String _deputyId;

  DeputySpeechesNetworkDataSource(this._deputiesDetailsApi, this._networkMapper, this._deputyId, this._localDataSource);

  @override
  Future<Result<List<SpeechModel>>> call(DeputySpeechesListParams params) async {
    try {
      if (params.easyFilter != null) {
        return Success(await _localDataSource.getSpeechModels(params.limit, params.offset, params.easyFilter!));
      }
      final response = await _deputiesDetailsApi.getSpeechesByDeputy(
          _deputyId,
          SpeechSearchRequest(
            params.limit,
            params.offset,
            params.searchQuery,
            null,
            null,
            params.sortingParam,
          ));

      final modelsList = await _networkMapper(response);
      _localDataSource.saveSpeechModels(response);

      return Success(modelsList);
    } catch (error) {
      return Failure(error);
    }
  }
}

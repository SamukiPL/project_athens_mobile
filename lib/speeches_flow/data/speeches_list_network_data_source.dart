import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/speeches_flow/data/network/request/speech_search_request.dart';
import 'package:project_athens/speeches_flow/data/network/speeches_api.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';

class SpeechesListNetworkDataSource extends NetworkListDataSource<SpeechModel, BaseListParams> {

  final SpeechesApi _speechesApi;
  final SpeechesNetworkMapper _networkMapper;

  SpeechesListNetworkDataSource(this._speechesApi, this._networkMapper);

  @override
  Future<Result<List<SpeechModel>>> call(BaseListParams params) async {
    try {
      final response = await _speechesApi.getSpeeches(
          SpeechSearchRequest(params.limit, params.offset, params.searchQuery,
              params.from?.toIso8601String(), params.to?.toIso8601String(), params.sortingParam, 9)
      );

      final modelsList = await _networkMapper(response.speeches);
      return Success(modelsList);
    } catch(error) {
      return Failure(error);
    }
  }

}
import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/deputies_flow/data/network/deputies_details_api.dart';
import 'package:project_athens/speeches_flow/data/network/request/speech_search_request.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';

class DeputySpeechesNetworkDataSource
    extends NetworkListDataSource<SpeechModel, BaseListParams> {
  final DeputiesDetailsApi _deputiesDetailsApi;
  final SpeechesNetworkMapper _networkMapper;

  final String _deputyId;

  DeputySpeechesNetworkDataSource(this._deputiesDetailsApi, this._networkMapper, this._deputyId);

  @override
  Future<Result<List<SpeechModel>>> call(
      BaseListParams params) async {
    try {
      final response = await _deputiesDetailsApi.getSpeechesByDeputy(
          _deputyId,
          SpeechSearchRequest(
              params.limit,
              params.offset,
              params.searchQuery,
              null,
              null,
              params.sortingParam,
              9));

      final modelsList = await _networkMapper(response);
      return Success(modelsList);
    } catch (error) {
      return Failure(error);
    }
  }
}

import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/speeches_flow/data/network/request/speech_search_request.dart';
import 'package:project_athens/speeches_flow/data/network/speeches_api.dart';
import 'package:project_athens/speeches_flow/data/speech_cache.dart';
import 'package:project_athens/speeches_flow/domain/filters/speeches_easy_filter.dart';
import 'package:project_athens/speeches_flow/domain/speeches_list_params.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';

class SpeechesListNetworkDataSource extends NetworkListDataSource<SpeechModel, SpeechesListParams> {

  final SpeechesApi _speechesApi;
  final SpeechesNetworkMapper _networkMapper;

  final SpeechCache _speechCache;
  final SubscribedDeputiesCache _subscribedDeputiesCache;

  SpeechesListNetworkDataSource(this._speechesApi, this._networkMapper, this._speechCache, this._subscribedDeputiesCache);

  @override
  Future<Result<List<SpeechModel>>> call(SpeechesListParams params) async {
    try {
      final response = await _speechesApi.getSpeeches(
          SpeechSearchRequest(params.limit, params.offset, params.searchQuery,
              params.from?.toIso8601String(), params.to?.toIso8601String(), params.sortingParam, 9)
      );

      final modelsList = await _networkMapper(response.speeches);
      _speechCache.saveSpeeches(modelsList);

      final filteredResults = await _filterByEasyFilter(modelsList, params.easyFilter);

      return Success(filteredResults);
    } catch(error) {
      return Failure(error);
    }
  }

  Future<List<SpeechModel>> _filterByEasyFilter(
      List<SpeechModel> result,
      SpeechesEasyFilter? easyFilter) async {
    if (easyFilter is SpeechesSubscribedFilter) {
      final subscribedDeputies = await _subscribedDeputiesCache.getSubsribedDeputies();
      final Set<String> subscribedDeputiesIdSet = new Set.from(subscribedDeputies.map((deputy) => deputy.cadencyDeputyId));
      final speeches = result
          .where((speech) => subscribedDeputiesIdSet.contains(speech.deputyId))
          .toList();
      return speeches;
    } else if (easyFilter is SpeechesParliamentClubFilter) {
      final speeches = result
          .where((element) => element.club?.id == easyFilter.id)
          .toList();
      return speeches;
    } else {
      return result;
    }
  }
}

import 'dart:async';

import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/speeches_flow/data/network/request/speech_search_request.dart';
import 'package:project_athens/speeches_flow/data/network/speeches_api.dart';
import 'package:project_athens/speeches_flow/domain/list/speeches_list_repository.dart';
import 'package:project_athens/speeches_flow/mappers/speeches_network_mapper.dart';
import 'package:rxdart/rxdart.dart';

class SpeechesListRepositoryImpl extends SpeechesListRepository {

  final SpeechesApi _speechesApi;

  final SpeechesNetworkMapper _networkMapper;

  final StreamController<Result<List<SpeechModel>>> _speechesSubject =
      BehaviorSubject<Result<List<SpeechModel>>>();

  List<SpeechModel> _cache = List.empty();

  SpeechesListRepositoryImpl(this._speechesApi, this._networkMapper);

  @override
  void dispose() {
    _speechesSubject.close();
  }

  @override
  Future<void> fetchItems(BaseListParams params) async {
    networkCall(params);
  }

  @override
  Stream<Result<List<SpeechModel>>> getItems(BaseListParams params) {
    networkCall(params);

    return _speechesSubject.stream;
  }

  @override
  Future<void> refreshItems(BaseListParams params) async {
    _cache = List.empty();
    networkCall(params);
  }

  Future<void> networkCall(BaseListParams params) async {
    final response = await _speechesApi.getAllDeputies(
      SpeechSearchRequest(params.limit, params.offset, params.searchQuery,
          params.from?.toIso8601String(), params.to?.toIso8601String(), params.sortingParam, 9)
    );

    final modelsList = await _networkMapper(response);
    _cache = _cache + modelsList;
    _speechesSubject.add(Success(modelsList));
  }
}

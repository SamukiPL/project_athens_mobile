import 'dart:async';
import 'dart:convert';

import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/voting_flow/data/network/request/vote_search_request.dart';
import 'package:project_athens/voting_flow/data/network/voting_api.dart';
import 'package:project_athens/voting_flow/domain/list/votes_list_repository.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';
import 'package:rxdart/rxdart.dart';

class VotesListRepositoryImpl extends VotesListRepository {

  final VotingApi _votingApi;

  final VotingNetworkMapper _networkMapper;

  final StreamController<Result<List<VotingModel>>> _speechesSubject = BehaviorSubject<Result<List<VotingModel>>>();

  List<VotingModel> _cache = List.empty();

  VotesListRepositoryImpl(this._votingApi, this._networkMapper);

  @override
  void dispose() {
    _speechesSubject.close();
  }

  @override
  Future<void> fetchItems(BaseListParams params) {
    return networkCall(params);
  }

  @override
  Stream<Result<List<VotingModel>>> getItems(BaseListParams params) {
    networkCall(params);

    return _speechesSubject.stream;
  }

  @override
  Future<void> refreshItems(BaseListParams params) async {
    _cache = List.empty();
    _speechesSubject.add(Refresh());
    networkCall(params);
  }

  Future<void> networkCall(BaseListParams params) async {
    try {
      final response = await _votingApi.getVoting(
          VoteSearchRequest(
              params.limit,
              params.offset,
              params.searchQuery,
              params.from?.toIso8601String(),
              params.to?.toIso8601String(),
              params.sortingParam,
              9)
      );

      final modelsList = await _networkMapper(response.votings);
      _cache = _cache + modelsList;
      _speechesSubject.add(Success(_cache));
    } catch(error) {
      _speechesSubject.add(Failure(error));
    }
  }
}
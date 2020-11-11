import 'dart:async';

import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/voting_flow/data/network/voting_api.dart';
import 'package:project_athens/voting_flow/domain/list/votes_list_repository.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';
import 'package:rxdart/rxdart.dart';

class VotesListRepositoryImpl extends VotesListRepository {

  final VotingApi _votingApi;

  final VotingNetworkMapper _networkMapper;

  final StreamController<Result<List<VotingModel>>> _speechesSubject = BehaviorSubject<Result<List<VotingModel>>>();

  VotesListRepositoryImpl(this._votingApi, this._networkMapper);

  @override
  Future<void> fetchItems(int limit, int offset) async {}

  @override
  Stream<Result<List<VotingModel>>> getItems(BaseParams params) {
    return _speechesSubject.stream;
  }

  @override
  Future<void> refreshItems() async {}

  @override
  void dispose() {
    _speechesSubject.close();
  }

}
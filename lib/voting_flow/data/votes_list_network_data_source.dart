import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_flow/mappers/vote_slim_network_mapper.dart';
import 'package:project_athens/voting_flow/data/votes_list_local_data_source.dart';
import 'package:project_athens/voting_flow/domain/votes_list_params.dart';

import 'network/request/vote_search_request.dart';
import 'network/voting_api.dart';

class VotesListNetworkDataSource
    extends NetworkListDataSource<VoteSlimModel, VotesListParams> {
  final VotingApi _votingApi;
  final VoteSlimNetworkMapper _networkMapper;
  final VotesListLocalDataSource _localDataSource;

  VotesListNetworkDataSource(
      this._votingApi, this._networkMapper, this._localDataSource);

  @override
  Future<Result<List<VoteSlimModel>>> call(VotesListParams params) async {
    try {
      if (params.easyFilter != null) {
        return Success(await _localDataSource.getVotingModels(
            params.limit, params.offset, params.easyFilter!));
      }

      final response = await _votingApi.getVoting(VoteSearchRequest(
          params.limit,
          params.offset,
          params.searchQuery,
          params.from?.toIso8601String(),
          params.to?.toIso8601String(),
          params.sortingParam,
          true));

      final modelsList = await _networkMapper(response.votes);
      _localDataSource.saveVotingModels(response.votes);

      return Success(modelsList);
    } catch (error) {
      return Failure(error);
    }
  }
}

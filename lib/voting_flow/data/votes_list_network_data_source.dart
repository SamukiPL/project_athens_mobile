import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/deputies_flow/mappers/vote_slim_network_mapper.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';

import 'network/request/vote_search_request.dart';
import 'network/voting_api.dart';

class VotesListNetworkDataSource extends NetworkListDataSource<VoteSlimModel, BaseListParams> {

  final VotingApi _votingApi;
  final VoteSlimNetworkMapper _networkMapper;

  VotesListNetworkDataSource(this._votingApi, this._networkMapper);

  @override
  Future<Result<List<VoteSlimModel>>> call(BaseListParams params) async {
    try {
      final response = await _votingApi.getVoting(
          VoteSearchRequest(
              params.limit,
              params.offset,
              params.searchQuery,
              params.from?.toIso8601String(),
              params.to?.toIso8601String(),
              params.sortingParam,
              9,
              true)
      );

      final modelsList = await _networkMapper(response.votes);
      return Success(modelsList);
    } catch(error) {
      return Failure(error);
    }
  }
}
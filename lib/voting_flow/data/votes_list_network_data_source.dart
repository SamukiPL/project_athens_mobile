import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';

import 'network/request/vote_search_request.dart';
import 'network/voting_api.dart';

class VotesListNetworkDataSource extends NetworkListDataSource<VotingModel, BaseListParams> {

  final VotingApi _votingApi;
  final VotingNetworkMapper _networkMapper;

  VotesListNetworkDataSource(this._votingApi, this._networkMapper);

  @override
  Future<Result<List<VotingModel>>> call(BaseListParams params) async {
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
      return Success(modelsList);
    } catch(error) {
      return Failure(error);
    }
  }
}
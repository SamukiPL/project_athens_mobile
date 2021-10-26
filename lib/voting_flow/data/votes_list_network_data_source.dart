import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_flow/mappers/vote_slim_network_mapper.dart';
import 'package:project_athens/voting_flow/domain/filters/votes_easy_filter.dart';
import 'package:project_athens/voting_flow/domain/votes_list_params.dart';

import 'network/request/vote_search_request.dart';
import 'network/voting_api.dart';

class VotesListNetworkDataSource extends NetworkListDataSource<VoteSlimModel, VotesListParams> {

  final VotingApi _votingApi;
  final VoteSlimNetworkMapper _networkMapper;

  VotesListNetworkDataSource(this._votingApi, this._networkMapper);

  @override
  Future<Result<List<VoteSlimModel>>> call(VotesListParams params) async {
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

      final filteredResults = _filterByEasyFilter(modelsList, params.easyFilter);

      return Success(filteredResults);
    } catch(error) {
      return Failure(error);
    }
  }

  List<VoteSlimModel> _filterByEasyFilter(
      List<VoteSlimModel> result,
      VotesEasyFilter? easyFilter) {
    if (easyFilter is VoteTypeFilter) {
      final filteredByType = result
          .where((element) => element.type == easyFilter.type)
          .toList();
      return filteredByType;
    } else if (easyFilter is AcceptedVoteFilter) {
      return result.where((element) => votePassed(element)).toList();
    } else if (easyFilter is RejectedVoteFilter) {
      return result.where((element) => !votePassed(element)).toList();
    } else {
      return result;
    }
  }

  bool votePassed(VoteSlimModel vote) {
    if (vote.absoluteMajority != null) {
      return vote.voteNumbers.inFavor > vote.absoluteMajority!;
    } else if (vote.qualifyingMajority != null) {
      return vote.voteNumbers.inFavor > vote.qualifyingMajority!;
    } else {
      return vote.voteNumbers.inFavor > vote.voteNumbers.against;
    }
  }
}

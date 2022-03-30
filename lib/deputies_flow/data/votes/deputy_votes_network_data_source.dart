import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_flow/data/network/deputies_details_api.dart';
import 'package:project_athens/deputies_flow/data/votes/deputy_votes_local_data_source.dart';
import 'package:project_athens/deputies_flow/domain/votes/deputy_votes_list_params.dart';
import 'package:project_athens/deputies_flow/mappers/vote_slim_network_mapper.dart';
import 'package:project_athens/voting_flow/data/network/request/vote_search_request.dart';

class DeputyVotesNetworkDataSource extends NetworkListDataSource<VoteSlimModel, DeputyVotesListParams> {
  final DeputiesDetailsApi _deputiesDetailsApi;
  final VoteSlimNetworkMapper _networkMapper;
  final DeputyVotesListLocalDataSource _localDataSource;

  final String _deputyId;

  DeputyVotesNetworkDataSource(this._deputiesDetailsApi, this._networkMapper, this._deputyId, this._localDataSource);

  @override
  Future<Result<List<VoteSlimModel>>> call(DeputyVotesListParams params) async {
    try {
      if (params.easyFilter != null) {
        return Success(await _localDataSource.getVoteModels(params.limit, params.offset, params.easyFilter!));
      }
      final response = await _deputiesDetailsApi.getVotesByDeputy(_deputyId,
          VoteSearchRequest(params.limit, params.offset, params.searchQuery, null, null, params.sortingParam, true));

      final modelsList = await _networkMapper(response);
      _localDataSource.saveVoteModels(response);

      return Success(modelsList);
    } catch (error) {
      return Failure(error);
    }
  }
}

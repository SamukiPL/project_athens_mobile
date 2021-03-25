import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/deputies_flow/data/network/deputies_details_api.dart';
import 'package:project_athens/voting_flow/data/network/request/vote_search_request.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';

class DeputyVotesNetworkDataSource
    extends NetworkListDataSource<VotingModel, BaseListParams> {
  final DeputiesDetailsApi _deputiesDetailsApi;
  final VotingNetworkMapper _networkMapper;

  final int _cadency;
  final String _deputyId;

  DeputyVotesNetworkDataSource(
      this._deputiesDetailsApi, this._networkMapper, this._cadency, this._deputyId);

  @override
  Future<Result<List<VotingModel>>> call(
      BaseListParams params) async {
    try {
      final response = await _deputiesDetailsApi.getVotesByDeputy(
          _cadency,
          _deputyId,
          VoteSearchRequest(
              params.limit,
              params.offset,
              params.searchQuery,
              params.from?.toIso8601String(),
              params.to?.toIso8601String(),
              params.sortingParam,
              _cadency));

      final modelsList = await _networkMapper(response);
      return Success(modelsList);
    } catch (error) {
      return Failure(error);
    }
  }
}

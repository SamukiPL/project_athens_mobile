import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/deputies_flow/data/network/deputies_details_api.dart';
import 'package:project_athens/deputies_flow/domain/vote_accuracy_alignment_enum.dart';
import 'package:project_athens/deputies_flow/mappers/vote_slim_network_mapper.dart';
import 'package:project_athens/voting_flow/data/network/request/vote_search_request.dart';

import '../domain/details/deputy_vote_accuracy_list_params.dart';

class VoteSlimModelNetworkDataSource extends NetworkListDataSource<VoteSlimModel, DeputyVoteAccuracyListParams> {

  final DeputiesDetailsApi _deputiesDetailsApi;
  final VoteSlimNetworkMapper _networkMapper;

  VoteSlimModelNetworkDataSource(this._deputiesDetailsApi, this._networkMapper);

  @override
  Future<Result<List<VoteSlimModel>>> call(DeputyVoteAccuracyListParams params) async {
    try {
      final alignment = params.accuracyType.toStringValue();
      final response = await _deputiesDetailsApi.getDeputyVoteAccuracy(
        params.cadencyDeputyId,
          params.parliamentClubId,
          alignment,
          VoteSearchRequest(
              params.limit,
              params.offset,
              params.searchQuery,
              params.from?.toIso8601String(),
              params.to?.toIso8601String(),
              params.sortingParam,
              9,
              true
          )
      );

      final modelsList = await _networkMapper.call(response.votes);
      return Success(modelsList);
    } catch(error) {
      return Failure(error);
    }
  }
}

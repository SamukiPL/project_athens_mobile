import 'package:project_athens/athens_core/data/base_list/network_data_source.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/utils/vote_accuracy_enum_to_string.dart';
import 'package:project_athens/deputies_flow/data/network/deputies_details_api.dart';
import 'package:project_athens/deputies_flow/mappers/vote_slim_majority_network_mapper.dart';
import 'package:project_athens/voting_flow/data/network/request/vote_search_request.dart';
import 'package:project_athens/voting_flow/mappers/voting_network_mapper.dart';

import 'network/request/deputy_vote_accuracy_list_params.dart';

class VotesListNetworkDataSource extends NetworkListDataSource<VotingModel, DeputyVoteAccuracyListParams> {

  final DeputiesDetailsApi _deputiesDetailsApi;
  final VoteSlimMajorityNetworkMapper _networkMapper;

  VotesListNetworkDataSource(this._deputiesDetailsApi, this._networkMapper);

  @override
  Future<Result<List<VotingModel>>> call(DeputyVoteAccuracyListParams params) async {
    try {
      final alignment = VoteAccuracyEnumToString(params.accuracyType);
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
              9)
      );

      final modelsList = await _networkMapper.call(response.votes);
      return Success(modelsList);
    } catch(error) {
      return Failure(error);
    }
  }


}
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/deputies_flow/data/network/response/deputy_vote_accuracy_response.dart';
import 'package:project_athens/deputies_flow/domain/vote_slim_majority_model.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';

class VoteSlimMajorityNetworkMapper extends AsyncDataMapper<VoteSlimDTO, VoteSlimMajorityModel> {
  final SubscribedDeputiesCache subscribedDeputiesCache;
  final DeputiesCache deputiesCache;
  final String cadencyDeputyId;

  VoteSlimMajorityNetworkMapper(this.subscribedDeputiesCache, this.deputiesCache, this.cadencyDeputyId);

  @override
  Future<VoteSlimMajorityModel> transform(VoteSlimDTO data) async {
    final subscribedDeputy = await subscribedDeputiesCache.getDeputyModelById(cadencyDeputyId);

  }


}
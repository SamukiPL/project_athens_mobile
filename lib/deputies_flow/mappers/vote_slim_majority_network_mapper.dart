import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/utils/get_vote_description_helper.dart';
import 'package:project_athens/deputies_flow/data/network/response/deputy_vote_accuracy_response.dart';
import 'package:project_athens/deputies_flow/domain/vote_slim_majority_model.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class VoteSlimMajorityNetworkMapper extends AsyncDataMapper<VoteSlimDTO, VoteSlimMajorityModel> {
  final SubscribedDeputiesCache subscribedDeputiesCache;
  final DeputiesCache deputiesCache;
  final String cadencyDeputyId;
  final ParliamentClubModel _parliamentClubModel;
  final AppLocalizations _localizations;

  VoteSlimMajorityNetworkMapper(this.subscribedDeputiesCache, this.deputiesCache, this.cadencyDeputyId, this._parliamentClubModel, this._localizations);

  @override
  Future<VoteSlimMajorityModel> transform(VoteSlimDTO data) async {
    final subscribedDeputy = await subscribedDeputiesCache.getDeputyModelById(cadencyDeputyId);

    final voteNumbers = VoteNumbers(absent: data.voteNumbers.absent, against: data.voteNumbers.against, hold: data.voteNumbers.hold, inFavor: data.voteNumbers.inFavor);
    final voteDesc = getVoteDescriptionHelper(data.type, _localizations);
    final voteSlim = VoteSlimMajorityModel(voteNumbers: voteNumbers, voteAt: data.voteAt, type: data.type, id: data.id, desiredClub: _parliamentClubModel, desiredClubVote: data.desiredClubVoteType, votingDesc: voteDesc, desiredDeputy: subscribedDeputy, desiredDeputyVote: data.desiredDeputyVoteType, title: data.agenda);

    return voteSlim;
  }


}
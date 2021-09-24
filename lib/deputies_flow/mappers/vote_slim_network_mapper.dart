import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/utils/get_vote_description_helper.dart';
import 'package:project_athens/deputies_flow/data/network/response/deputy_vote_accuracy_response.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class VoteSlimNetworkMapper extends AsyncDataMapper<VoteSlimDTO, VoteSlimModel> {
  final SubscribedDeputiesCache _subscribedDeputiesCache;
  final DeputiesCache _deputiesCache;
  final AppLocalizations _localizations;

  VoteSlimNetworkMapper(this._subscribedDeputiesCache, this._deputiesCache, this._localizations);

  @override
  Future<VoteSlimModel> transform(VoteSlimDTO data) async {
    final deputiesVoteFutures = data.deputiesVoteType.map((deputyDTO) async {
      final deputy = await _subscribedDeputiesCache.getDeputyModelById(deputyDTO.cadencyDeputy) as SubscribedDeputyModel;
      
      return VoteSlimDeputyVoteType(deputy, deputyDTO.voteType);
    }).toList();
    
    final deputiesVote = await Future.wait(deputiesVoteFutures);
    
    final clubsFutures = data.clubsMajority.map((clubDTO) async {
      final club = await _deputiesCache.getParliamentClubModel(clubDTO.parliamentClub);
      
      return VoteSlimClubMajority(club!, clubDTO.voteMajority, clubDTO.deputyCardNumbers);
    });

    final clubs = await Future.wait(clubsFutures);

    final voteNumbers = VoteNumbers(absent: data.voteNumbers.absent, against: data.voteNumbers.against, hold: data.voteNumbers.hold, inFavor: data.voteNumbers.inFavor);
    final voteDesc = getVoteDescriptionHelper(data.type, _localizations);
    
    final voteSlim = VoteSlimModel(
      id: data.id,
      title: data.agenda,
      votingDesc: voteDesc,
      type: data.type,
      voteAt: data.voteAt,
      absoluteMajority: data.absoluteMajority,
      qualifyingMajority: data.qualifyingMajority,
      voteNumbers: voteNumbers,
      clubsMajority: clubs,
      deputiesVote: deputiesVote,
      orderPoint: data.orderPoint
    );

    return voteSlim;
  }
}
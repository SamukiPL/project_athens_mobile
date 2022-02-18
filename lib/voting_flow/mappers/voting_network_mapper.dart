import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/utils/get_vote_description_helper.dart';
import 'package:project_athens/voting_flow/mappers/map_to_voting_type.dart';

class VotingNetworkMapper extends AsyncDataMapper<VotingResponse, VotingModel> {

  final AppLocalizations _localizations;

  VotingNetworkMapper(this._localizations);

  @override
  Future<VotingModel> transform(VotingResponse data) async {
    final results = VoteResultModel(data.inFavor, data.against, data.hold, data.absent);
    final voteModels = data.votes.map((vote) => VoteModel(VoteType.values[vote.type], vote.cadencyDeputy)).toList();
    final VotingType votingType = getVotingTypeFromInt(data.votingType);
    return VotingModel(
    id: data.id,
    title: data.topic,
    date: data.votedAt,
    absoluteMajority: data.absoluteMajority,
    qualifyingMajority: data.qualifyingMajority,
    votingDesc: getVoteDescriptionHelper(votingType, _localizations),
    votingType: votingType,
    results: results,
    votes: voteModels,
    clubVotes: data.parliamentClubVotingNumbers,
    orderPoint: data.orderPoint,
    deputyVoteType: VoteType.values[data.deputyVoteType != null ? data.deputyVoteType! : 1],
    viewed: data.viewed == true,
    createAt: data.createAt,
    // since for now service does NOT provide updates
    // because votes for now are immutable on server side
    updateAt: data.createAt
    );
  }
}

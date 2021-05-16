import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';

class VotingNetworkMapper extends AsyncDataMapper<VotingResponse, VotingModel> {

  final AppLocalizations _localizations;

  VotingNetworkMapper(this._localizations);

  @override
  Future<VotingModel> transform(VotingResponse data) async {
    final results = VoteResultModel(data.inFavor, data.against, data.hold, data.absent);
    final voteModels = data.votes.map((vote) => VoteModel(VoteType.values[vote.type], vote.cadencyDeputy)).toList();
    return VotingModel(
    id: data.id,
    title: data.topic,
    date: data.actualVotedAt,
    absoluteMajority: data.absoluteMajority,
    qualifyingMajority: data.qualifyingMajority,
    votingDesc: getVotingDesc(data.votingType),
    results: results,
    votes: voteModels,
    clubVotes: data.parliamentClubVotingNumbers,
    orderPoint: data.orderPoint,
    deputyVoteType: VoteType.values[data.deputyVoteType != null ? data.deputyVoteType : 1]);
  }

  String getVotingDesc(VotingType type) {
    switch (type) {
      case VotingType.RESOLUTION_PROJECT:
        return _localizations.getText().timelineVotingTypesResolutionProject();
        break;
      case VotingType.LAW_PROJECT:
        return _localizations.getText().timelineVotingTypesLawProject();
        break;
      case VotingType.BREAK:
        return _localizations.getText().timelineVotingTypesBreak();
        break;
      case VotingType.QUORUM:
        return _localizations.getText().timelineVotingTypesQuorum();
        break;
      case VotingType.REPORT:
        return _localizations.getText().timelineVotingTypesReport();
        break;
      case VotingType.VOTE_OF_NO_CONFIDENCE:
        return _localizations.getText().timelineVotingTypesVoteOfNoConfidence();
        break;
      case VotingType.COMPLETION_OF_AGENDA:
        return _localizations.getText().timelineVotingTypesCompletionOfAgenda();
        break;
      case VotingType.SHORTENING_DEADLINE:
        return _localizations.getText().timelineVotingTypesShorteningDeadline();
        break;
      case VotingType.CHANGE_COMISSION_MEMBERS:
        return _localizations.getText().timelineVotingTypesChangeCommissionMembers();
        break;
      case VotingType.VOTE_FOR_PROPOSAL:
        return _localizations.getText().timelineVotingTypesVoteForProposal();
        break;
      case VotingType.PERSON_VOTE:
        return _localizations.getText().timelineVotingTypesPersonVote();
        break;
      case VotingType.UNKNOWN:
        return _localizations.getText().timelineVotingTypesUnknown();
        break;
      default:
        throw Exception("There is no other VotingType!");
    }
  }

}
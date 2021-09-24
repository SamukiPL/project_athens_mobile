import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';
import 'package:project_athens/athens_core/data/base_responses/timeline_response.dart';
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';

class TimelineModelMapper extends AsyncDataMapper<Event, TimelineModel> {

  final DeputiesCache _deputiesCache;

  final AppLocalizations _localizations;

  TimelineModelMapper(this._deputiesCache, this._localizations);

  @override
  Future<TimelineModel> transform(Event data) async {
    switch (data.type) {
      case TimelineEventType.VOTING:
        return getVotingModel(data.item as VotingResponse);
        break;
      case TimelineEventType.SPEECH:
        return await getSpeechModel(data.item as SpeechResponse);
        break;
      default:
        throw Exception("There is no other TimelineEventType");
    }
  }

  TimelineModel getVotingModel(VotingResponse item) {
    final results = VoteResultModel(item.inFavor, item.against, item.hold, item.absent);
    final voteModels = item.votes.map((vote) => VoteModel(VoteType.values[vote.type], vote.cadencyDeputy)).toList();
    return VotingModel(
        id: item.id,
        title: item.topic,
        date: item.votedAt,
        votingDesc: getVotingDesc(item.votingType),
        results: results,
        votes: voteModels,
        orderPoint: item.orderPoint,
        clubVotes: item.parliamentClubVotingNumbers,
        createAt: item.createAt,
        // since for now service does NOT provide updates
        // because votes for now are immutable on server side
        updateAt: item.createAt
    );
  }

  Future<TimelineModel> getSpeechModel(SpeechResponse item) async {
    return SpeechModel(
      id: item.id,
      personName: item.personName,
      deputyId: item.cadencyDeputy,
      club: await _deputiesCache.getParliamentClubModel(item.parliamentClub),
      desc: item.agenda?.title,
      date: item.cisInfo.eventDateTime,
      thumbnailUrl: await _deputiesCache.getDeputyThumbnail(item.cadencyDeputy),
      videoUrl: item.videoDownloadUrl,
      updateAt: item.updateAt,
      createAt: item.createAt
    );
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
      case VotingType.VOTE_FOR_POSTPONEMENT_GATHERING:
        return _localizations.getText().timelineVotingTypesVoteForPostponementGathering();
        break;
      case VotingType.MARSHAL:
        return _localizations.getText().timelineVotingTypesMarshal();
        break;
      case VotingType.VICE_MARSHAL:
        return _localizations.getText().timelineVotingTypesViceMarshal();
        break;
      case VotingType.CHOOSE_COMISSION_MEMBERS:
        return _localizations.getText().timelineVotingTypesChooseComissionMembers();
        break;
      case VotingType.SELECTION_OF_PARLIAMENT_SECRETARIES:
        return _localizations.getText().timelineVotingTypesSelectionOfParliamentSecretaries();
        break;
      case VotingType.VOTE_OF_CONFIDENCE:
        return _localizations.getText().timelineVotingTypesVoteOfConfidence();
        break;
      case VotingType.SELECTION_OF_STATE_TRIBUNAL:
        return _localizations.getText().timelineVotingTypesSelectionOfStateTribunal();
        break;
      case VotingType.SELECTION_OF_CONSTITUTIONAL_COURT:
        return _localizations.getText().timelineVotingTypesSelectionOfConstitutionalCourt();
        break;
      case VotingType.SELECTION_OF_DEPUTY_MEMBER_NATIONAL_COUNCIL_JUDICIARY:
        return _localizations.getText().timelineVotingTypesSelectionOfNationalCouncilJudiciary();
        break;
      case VotingType.UNKNOWN:
        return _localizations.getText().timelineVotingTypesUnknown();
        break;
      default:
        throw Exception("There is no other VotingType!");
    }
  }
}

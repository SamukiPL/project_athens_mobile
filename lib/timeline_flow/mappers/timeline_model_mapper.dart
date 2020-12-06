import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
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
        return getVotingModel(data.item);
        break;
      case TimelineEventType.SPEECH:
        return await getSpeechModel(data.item);
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
        date: item.actualVotedAt,
        votingDesc: getVotingDesc(item.votingType),
        results: results,
        votes: voteModels);
  }

  Future<TimelineModel> getSpeechModel(SpeechResponse item) async {
    return SpeechModel(
      id: item.id,
      personName: item.personName,
      deputyId: item.cadencyDeputy,
      club:  (await _deputiesCache.getParliamentClubModel(item.parliamentClub))?.shortName ?? '',
      desc: item.agenda?.title,
      date: item.cisInfo.eventDateTime,
      thumbnailUrl: await _deputiesCache.getDeputyThumbnail(item.cadencyDeputy),
      videoUrl: item.videoDownloadUrl
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
      case VotingType.UNKNOWN:
        return _localizations.getText().timelineVotingTypesUnknown();
        break;
      default:
        throw Exception("There is no other VotingType!");
    }
  }
}

import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/timeline_flow/data/network/response/speech.dart';
import 'package:project_athens/timeline_flow/data/network/response/timeline_response.dart';
import 'package:project_athens/timeline_flow/data/network/response/voting.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';

class TimelineModelMapper extends DataMapper<Event, TimelineModel> {

  final DeputiesCache _deputiesCache;

  final AppLocalizations _localizations;

  TimelineModelMapper(this._deputiesCache, this._localizations);

  @override
  TimelineModel transform(Event data) {
    switch (data.type) {
      case TimelineEventType.VOTING:
        return getVotingModel(data.item);
        break;
      case TimelineEventType.SPEECH:
        return getSpeechModel(data.item);
        break;
      default:
        throw Exception("There is no other TimelineEventType");
    }
  }

  TimelineModel getVotingModel(Voting item) {
    return VotingModel(item.id, item.topic, item.actualVotedAt, getVotingDesc(item.votingType));
  }

  TimelineModel getSpeechModel(Speech item) {
    return SpeechModel(
      item.id,
      item.personName,
      item.parliamentClub,
      item.agenda?.title,
      item.cisInfo.eventDateTime,
      _deputiesCache.getDeputyThumbnail(item.cadencyDeputy),
      item.videoDownloadUrl
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

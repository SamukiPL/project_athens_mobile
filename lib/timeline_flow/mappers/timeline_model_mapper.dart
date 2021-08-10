import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/utils/get_vote_description_helper.dart';
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
        date: item.votedAt,
        votingDesc: getVoteDescriptionHelper(item.votingType, _localizations),
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
}

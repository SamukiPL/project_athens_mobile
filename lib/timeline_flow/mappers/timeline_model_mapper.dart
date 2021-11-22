import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';
import 'package:project_athens/athens_core/data/base_responses/timeline_response.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/timeline_voting_model.dart';
import 'package:project_athens/athens_core/utils/get_vote_description_helper.dart';
import 'package:project_athens/deputies_flow/data/network/response/deputy_vote_accuracy_response.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class TimelineModelMapper extends AsyncDataMapper<Event, TimelineModel> {
  final DeputiesCache _deputiesCache;
  final ParliamentClubsCache _clubsCache;
  final SubscribedDeputiesCache _subscribedDeputiesCache;

  final AppLocalizations _localizations;

  TimelineModelMapper(
      this._deputiesCache, this._clubsCache, this._subscribedDeputiesCache, this._localizations);

  @override
  Future<TimelineModel> transform(Event data) async {
    switch (data.type) {
      case TimelineEventType.VOTING:
        return await getVotingModel(data.item as VoteSlimDTO);
      case TimelineEventType.SPEECH:
        return await getSpeechModel(data.item as SpeechResponse);
      default:
        throw Exception("There is no other TimelineEventType");
    }
  }

  Future<TimelineModel> getVotingModel(VoteSlimDTO item) async {
    final deputiesVoteFutures = item.deputiesVoteType.map((deputyDTO) async {
      final deputy = await _subscribedDeputiesCache
          .getDeputyModelById(deputyDTO.cadencyDeputy);

      return VoteSlimDeputyVoteType(deputy as SubscribedDeputyModel, deputyDTO.voteType);
    }).toList();

    final deputiesVote = await Future.wait(deputiesVoteFutures);

    final clubsFutures = item.clubsMajority.map((clubDTO) async {
      final club =
          await _clubsCache.getParliamentClubModel(clubDTO.parliamentClub);

      return VoteSlimClubMajority(club!, clubDTO.voteMajority, clubDTO.deputyCardNumbers);
    });

    final clubs = await Future.wait(clubsFutures);

    final results = VoteNumbers(
        inFavor: item.voteNumbers.inFavor,
        against: item.voteNumbers.against,
        hold: item.voteNumbers.hold,
        absent: item.voteNumbers.absent);
    return TimelineVotingModel(
        id: item.id,
        title: item.agenda,
        voteAt: item.voteAt,
        votingDesc: getVoteDescriptionHelper(item.type, _localizations),
        voteNumbers: results,
        orderPoint: item.orderPoint,
        clubsMajority: clubs,
        deputiesVote: deputiesVote,
        createAt: DateTime.now(),
        absoluteMajority: item.absoluteMajority,
        voteType: item.type,
        qualifyingMajority: item.qualifyingMajority,
        agenda: item.agenda,
        // since for now service does NOT provide updates
        // because votes for now are immutable on server side
        updateAt: DateTime.now());
  }

  Future<TimelineModel> getSpeechModel(SpeechResponse item) async {
    return SpeechModel(
        id: item.id,
        personName: item.personName,
        deputyId: item.cadencyDeputy,
        club: await _clubsCache.getParliamentClubModel(item.parliamentClub),
        desc: item.agenda?.title,
        date: item.cisInfo.eventDateTime,
        thumbnailUrl:
            await _deputiesCache.getDeputyThumbnail(item.cadencyDeputy!),
        videoUrl: item.videoDownloadUrl,
        updateAt: item.updateAt,
        createAt: item.createAt);
  }
}

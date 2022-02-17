import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/utils/get_vote_description_helper.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/voting_flow/data/db/voting_dao.dart';
import 'package:project_athens/voting_flow/mappers/map_to_voting_type.dart';

class VotingModelDaoMapper
    extends AsyncDataMapper<VoteSlimEntityData, VoteSlimModel> {
  final AthensDatabase _database;
  final SubscribedDeputiesCache _subscribedDeputiesCache;
  final ParliamentClubsCache _clubsCache;
  final AppLocalizations _localizations;

  VotingModelDaoMapper(this._database, this._subscribedDeputiesCache,
      this._clubsCache, this._localizations);

  @override
  Future<VoteSlimModel> transform(VoteSlimEntityData data) async {
    final votingType = getVotingTypeFromInt(data.votingType);
    final results = VoteNumbers(
        inFavor: data.inFavor,
        against: data.against,
        hold: data.hold,
        absent: data.absent);
    final clubs = await _database.getVotesForVoting(data.id);
    final deputiesData = await _database.getClubNumbersForVoting(data.id);
    final deputies = deputiesData.map((e) => mapDeputyVote(e));

    return VoteSlimModel(
        id: data.id,
        title: data.title,
        type: votingType,
        voteAt: data.date,
        voteNumbers: results,
        votingDesc: getVoteDescriptionHelper(votingType, _localizations),
        qualifyingMajority: data.qualifyingMajority,
        orderPoint: data.orderPoint,
        absoluteMajority: data.absoluteMajority,
        clubsMajority: await mapClubs(clubs),
        deputiesVote: await Future.wait(deputies),
        viewed: data.viewed);
  }

  Future<List<VoteSlimClubMajority>?> mapClubs(
      List<SlimClubMajorityEntityData> data) async {
    final grouped = Map<String, List<int>>();
    data.forEach((element) {
      if (grouped[element.parliamentClubId] == null) {
        grouped[element.parliamentClubId] = List.empty(growable: true);
      }
      grouped[element.parliamentClubId]!.add(element.deputyCardNumber);
    });

    final clubs = await _clubsCache.parliamentClubs;
    if (clubs.isFailure()) return null;

    return grouped
        .map((key, value) {
          final clubModel = clubs
              .toSuccess()
              .value
              .firstWhere((element) => element.id == key);
          final voteMajority = VoteType.values[data
              .firstWhere((element) => element.parliamentClubId == key)
              .voteMajority];
          return MapEntry(
              key, VoteSlimClubMajority(clubModel, voteMajority, value));
        })
        .values
        .toList();
  }

  Future<VoteSlimDeputyVoteType> mapDeputyVote(
      SlimDeputyVoteTypeEntityData data) async {
    final deputy =
        await _subscribedDeputiesCache.getDeputyModelById(data.deputyId);
    return VoteSlimDeputyVoteType(deputy, VoteType.values[data.type]);
  }
}

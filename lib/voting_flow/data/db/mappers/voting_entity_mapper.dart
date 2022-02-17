import 'package:drift/drift.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/ext/db_value_extension.dart';
import 'package:project_athens/deputies_flow/data/network/response/deputy_vote_accuracy_response.dart';
import 'package:project_athens/voting_flow/data/db/mappers/insertable_voting_model.dart';

class VotingEntityMapper
    extends DataMapper<VoteSlimDTO, InsertableSlimVoteModel> {
  @override
  InsertableSlimVoteModel transform(VoteSlimDTO data) {
    final clubs = getClubMajority(data);
    return InsertableSlimVoteModel(
        entity: getVotingEntity(data),
        clubMajority: clubs,
        deputyVoteType: getClubNumberEntity(data));
  }

  VoteSlimEntityCompanion getVotingEntity(VoteSlimDTO data) =>
      VoteSlimEntityCompanion.insert(
          id: data.id,
          date: data.voteAt,
          title: data.agenda,
          votingType: data.type.index,
          inFavor: data.voteNumbers.inFavor,
          against: data.voteNumbers.against,
          hold: data.voteNumbers.hold,
          absent: data.voteNumbers.absent,
          orderPoint: ValueExt.absentIfNull(data.orderPoint),
          qualifyingMajority: ValueExt.absentIfNull(data.qualifyingMajority),
          absoluteMajority: ValueExt.absentIfNull(data.absoluteMajority),
          viewed: data.viewed == true);

  List<SlimClubMajorityEntityCompanion> getClubMajority(VoteSlimDTO data) =>
      data.clubsMajority
          .expand((club) {
        if (club.deputyCardNumbers.isEmpty) {
          return [SlimClubMajorityEntityCompanion.insert(votingId: data.id,
              parliamentClubId: club.parliamentClub,
              voteMajority: club.voteMajority.index,
              deputyCardNumber: Value.absent())
          ];
        }
        return club.deputyCardNumbers.map((deputy) =>
            SlimClubMajorityEntityCompanion.insert(
                votingId: data.id,
                parliamentClubId: club.parliamentClub,
                voteMajority: club.voteMajority.index,
                deputyCardNumber: ValueExt.absentIfNull(deputy)));
      })
          .toList();

  List<SlimDeputyVoteTypeEntityCompanion> getClubNumberEntity(
      VoteSlimDTO data) =>
      data.deputiesVoteType
          .map((deputy) =>
          SlimDeputyVoteTypeEntityCompanion.insert(
              votingId: data.id,
              deputyId: deputy.cadencyDeputy,
              type: deputy.voteType.index))
          .toList();
}

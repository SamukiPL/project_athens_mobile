import 'package:drift/drift.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/voting_flow/data/db/mappers/insertable_voting_model.dart';

extension VotingDao on AthensDatabase {
  Future<void> insertVotingModel(InsertableSlimVoteModel model) async {
    await batch((batch) {
      batch.insert(voteSlimEntity, model.entity, mode: InsertMode.insertOrReplace);
      batch.insertAllOnConflictUpdate(slimClubMajorityEntity, model.clubMajority);
      batch.insertAllOnConflictUpdate(slimDeputyVoteTypeEntity, model.deputyVoteType);
    });
  }

  Future<void> insertVotingModelsList(List<InsertableSlimVoteModel> models) async {
    models.forEach((element) {
      insertVotingModel(element);
    });
  }

  Future<List<VoteSlimEntityData>> getVotings(
      int limit, int offset, List<Expression<bool?> Function($VoteSlimEntityTable tbl)>? where) async {
    final query = select(voteSlimEntity);

    where?.forEach((whereClause) => query.where(whereClause));

    query.limit(limit, offset: offset);
    return query.get();
  }

  Future<void> voteWasSeen(String voteId) async {
    (update(voteSlimEntity)..where((tbl) => tbl.id.equals(voteId))).write(VoteSlimEntityCompanion(viewed: Value(true)));
  }

  Future<List<SlimClubMajorityEntityData>> getVotesForVoting(String votingId) {
    final query = select(slimClubMajorityEntity);
    query.where((tbl) => tbl.votingId.equals(votingId));
    return query.get();
  }

  Future<List<SlimDeputyVoteTypeEntityData>> getClubNumbersForVoting(String votingId) {
    final query = select(slimDeputyVoteTypeEntity);
    query.where((tbl) => tbl.votingId.equals(votingId));
    return query.get();
  }
}

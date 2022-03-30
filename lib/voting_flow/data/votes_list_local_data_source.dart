import 'package:drift/drift.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/deputies_flow/data/network/response/deputy_vote_accuracy_response.dart';
import 'package:project_athens/voting_flow/data/db/mappers/voting_entity_mapper.dart';
import 'package:project_athens/voting_flow/data/db/mappers/voting_model_dao_mapper.dart';
import 'package:project_athens/voting_flow/data/db/voting_dao.dart';
import 'package:project_athens/voting_flow/domain/filters/votes_easy_filter.dart';

class VotesListLocalDataSource {
  final AthensDatabase _database;
  final VotingEntityMapper _toEntityMapper;
  final VotingModelDaoMapper _toModelMapper;

  VotesListLocalDataSource(this._database, this._toEntityMapper, this._toModelMapper);

  Future<void> saveVotingModels(List<VoteSlimDTO> models) async {
    final insertables = _toEntityMapper(models);
    _database.insertVotingModelsList(insertables);
  }

  Future<List<VoteSlimModel>> getVotingModels(int limit, int offset, VotesEasyFilter easyFilter) async {
    final entities = await _database.getVotings(limit, offset, [_getEasyFilterWhere(easyFilter)]);
    return _toModelMapper(entities);
  }

  Expression<bool?> Function($VoteSlimEntityTable) _getEasyFilterWhere(VotesEasyFilter easyFilter) {
    if (easyFilter is VoteSeenFilter) {
      return (tbl) => tbl.viewed.equals(true);
    } else if (easyFilter is VoteNotSeenFilter) {
      return (tbl) => tbl.viewed.equals(false);
    } else if (easyFilter is VoteTypeFilter) {
      return (tbl) => tbl.votingType.equals(easyFilter.type.index);
    } else if (easyFilter is AcceptedVoteFilter) {
      return (tbl) => _votePassed(tbl);
    } else if (easyFilter is RejectedVoteFilter) {
      return (tbl) => _votePassed(tbl).not();
    } else {
      throw ArgumentError("There is no other VotesEasyFilter");
    }
  }

  Expression<bool?> _votePassed($VoteSlimEntityTable tbl) {
    if (tbl.absoluteMajority.isNotNull().isLiteral) {
      return tbl.inFavor.isBiggerThan(tbl.absoluteMajority);
    } else if (tbl.qualifyingMajority.isNotNull().isLiteral) {
      tbl.inFavor.isBiggerThan(tbl.qualifyingMajority);
    }
    return tbl.inFavor.isBiggerThan(tbl.against);
  }
}

import 'package:drift/drift.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/deputies_flow/data/network/response/deputy_vote_accuracy_response.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputy_votes_easy_filter.dart';
import 'package:project_athens/voting_flow/data/db/mappers/voting_entity_mapper.dart';
import 'package:project_athens/voting_flow/data/db/mappers/voting_model_dao_mapper.dart';
import 'package:project_athens/voting_flow/data/db/voting_dao.dart';

class DeputyVotesListLocalDataSource {
  final AthensDatabase _database;
  final VotingEntityMapper _toEntityMapper;
  final VotingModelDaoMapper _toModelMapper;
  final String _currentDeputyId;

  DeputyVotesListLocalDataSource(this._database, this._toEntityMapper, this._toModelMapper, this._currentDeputyId);

  Future<void> saveVoteModels(List<VoteSlimDTO> responses) async {
    final insertables = _toEntityMapper(responses);
    _database.insertVotingModelsList(insertables);
  }

  Future<List<VoteSlimModel>> getVoteModels(int limit, int offset, DeputyVotesEasyFilter easyFilter) async {
    final entities = await _database
        .getVotings(limit, offset, [_getEasyFilterWhere(easyFilter), _getDeputyFilterWhere(_currentDeputyId)]);
    return _toModelMapper(entities);
  }

  Expression<bool?> Function($VoteSlimEntityTable) _getEasyFilterWhere(DeputyVotesEasyFilter easyFilter) {
    if (easyFilter is DeputyVoteSeenFilter) {
      return ($VoteSlimEntityTable tbl) => tbl.viewed.equals(true);
    } else if (easyFilter is DeputyVoteNotSeenFilter) {
      return ($VoteSlimEntityTable tbl) => tbl.viewed.equals(false);
    } else {
      throw ArgumentError("There is no other DeputyVotesEasyFilter");
    }
  }

  Expression<bool?> Function($VoteSlimEntityTable) _getDeputyFilterWhere(String deputyId) {
    return ($VoteSlimEntityTable tbl) => tbl.downloadedForDeputy.equals(deputyId);
  }
}

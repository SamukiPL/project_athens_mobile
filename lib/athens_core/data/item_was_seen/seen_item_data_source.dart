import 'package:project_athens/athens_core/data/item_was_seen/network/seen_item_api.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/voting_flow/data/db/voting_dao.dart';
import 'package:project_athens/speeches_flow/data/db/speech_dao.dart';


class SeenItemDataSource {
  final SeenItemApi _seenItemApi;
  final AthensDatabase _database;

  SeenItemDataSource(this._seenItemApi, this._database);

  Future<Result<void>> setVoteWasSeen(String votingId) async {
    try {
      await _seenItemApi.setVoteSeen(votingId);
      await _database.voteWasSeen(votingId);

      return Success({});
    } catch(error) {
      return Failure(error);
    }
  }

  Future<Result<void>> setSpeechWasSeen(String speechId) async {
    try {
      await _seenItemApi.setSpeechSeen(speechId);
      await _database.speechWasSeen(speechId);

      return Success({});
    } catch(error) {
      return Failure(error);
    }
  }
}
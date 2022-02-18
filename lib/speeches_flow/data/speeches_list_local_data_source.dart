import 'package:drift/drift.dart';
import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:project_athens/speeches_flow/data/db/mappers/speech_entity_mapper.dart';
import 'package:project_athens/speeches_flow/data/db/mappers/speech_model_dao_mapper.dart';
import 'package:project_athens/speeches_flow/data/db/speech_dao.dart';
import 'package:project_athens/speeches_flow/domain/filters/speeches_easy_filter.dart';

class SpeechesListLocalDataSource {
  final AthensDatabase _database;
  final SpeechEntityMapper _toEntityMapper;
  final SpeechModelDaoMapper _toModelMapper;
  final SubscribedDeputiesCache _subscribedDeputiesCache;

  SpeechesListLocalDataSource(this._database, this._toEntityMapper,
      this._toModelMapper, this._subscribedDeputiesCache);

  Future<void> saveSpeechModels(List<SpeechResponse> responses) async {
    final insertables = _toEntityMapper(responses);
    _database.insertSpeechesList(insertables);
  }

  Future<List<SpeechModel>> getSpeechModels(
      int limit, int offset, SpeechesEasyFilter easyFilter) async {
    final entities = await _database.getSpeeches(
        limit, offset, await _getEasyFilterWhere(easyFilter));
    return _toModelMapper(entities);
  }

  Future<Expression<bool?> Function($SpeechEntityTable)> _getEasyFilterWhere(
      SpeechesEasyFilter easyFilter) async {
    if (easyFilter is SpeechSeenFilter) {
      return ($SpeechEntityTable tbl) => tbl.viewed.equals(true);
    } else if (easyFilter is SpeechNotSeenFilter) {
      return ($SpeechEntityTable tbl) => tbl.viewed.equals(false);
    } else if (easyFilter is SpeechesSubscribedFilter) {
      final subscribedDeputies =
          await _subscribedDeputiesCache.getSubsribedDeputies();
      final Set<String> subscribedDeputiesIdSet = new Set.from(
          subscribedDeputies.map((deputy) => deputy.cadencyDeputyId));
      return ($SpeechEntityTable tbl) =>
          tbl.deputyId.isIn(subscribedDeputiesIdSet);
    } else if (easyFilter is SpeechesParliamentClubFilter) {
      return ($SpeechEntityTable tbl) => tbl.clubId.equals(easyFilter.id);
    } else {
      throw ArgumentError("There is no other SpeechesEasyFilter");
    }
  }
}

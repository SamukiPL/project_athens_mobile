import 'package:drift/drift.dart';
import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/deputies_flow/domain/filters/deputy_speeches_easy_filter.dart';
import 'package:project_athens/speeches_flow/data/db/mappers/speech_entity_mapper.dart';
import 'package:project_athens/speeches_flow/data/db/mappers/speech_model_dao_mapper.dart';
import 'package:project_athens/speeches_flow/data/db/speech_dao.dart';

class DeputySpeechesListLocalDataSource {
  final AthensDatabase _database;
  final SpeechEntityMapper _toEntityMapper;
  final SpeechModelDaoMapper _toModelMapper;
  final String _currentDeputyId;

  DeputySpeechesListLocalDataSource(this._database, this._toEntityMapper, this._toModelMapper, this._currentDeputyId);

  Future<void> saveSpeechModels(List<SpeechResponse> responses) async {
    final insertables = _toEntityMapper(responses);
    _database.insertSpeechesList(insertables);
  }

  Future<List<SpeechModel>> getSpeechModels(int limit, int offset, DeputySpeechesEasyFilter easyFilter) async {
    final entities = await _database
        .getSpeeches(limit, offset, [await _getEasyFilterWhere(easyFilter), _getDeputyFilterWhere(_currentDeputyId)]);
    return _toModelMapper(entities);
  }

  Future<Expression<bool?> Function($SpeechEntityTable)> _getEasyFilterWhere(
      DeputySpeechesEasyFilter easyFilter) async {
    if (easyFilter is DeputySpeechSeenFilter) {
      return ($SpeechEntityTable tbl) => tbl.viewed.equals(true);
    } else if (easyFilter is DeputySpeechNotSeenFilter) {
      return ($SpeechEntityTable tbl) => tbl.viewed.equals(false);
    } else {
      throw ArgumentError("There is no other DeputySpeechesEasyFilter");
    }
  }

  Expression<bool?> Function($SpeechEntityTable) _getDeputyFilterWhere(String _currentDeputyId) {
    return ($SpeechEntityTable tbl) => tbl.deputyId.equals(_currentDeputyId);
  }
}

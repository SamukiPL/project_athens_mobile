import 'package:drift/drift.dart';
import 'package:project_athens/athens_core/db/athens_db.dart';

extension SpeechDao on AthensDatabase {
  Future<void> insertSpeech(SpeechEntityCompanion data) async {
    await batch((batch) => batch.insert(speechEntity, data, mode: InsertMode.insertOrReplace));
  }

  Future<void> insertSpeechesList(List<SpeechEntityCompanion> data) async {
    data.forEach((element) {
      insertSpeech(element);
    });
  }

  Future<List<SpeechEntityData>> getSpeeches(
      int limit, int offset, List<Expression<bool?> Function($SpeechEntityTable tbl)>? where) async {
    final query = select(speechEntity);

    where?.forEach((whereClause) => query.where(whereClause));

    query.limit(limit, offset: offset);
    return query.get();
  }

  Future<void> speechWasSeen(String speechId) async {
    (update(speechEntity)..where((tbl) => tbl.id.equals(speechId))).write(SpeechEntityCompanion(viewed: Value(true)));
  }
}

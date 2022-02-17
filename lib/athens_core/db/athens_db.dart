import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:project_athens/speeches_flow/data/db/speech_entity.dart';
import 'package:project_athens/voting_flow/data/db/slim_club_majority_entity.dart';
import 'package:project_athens/voting_flow/data/db/slim_deputy_vote_type_entity.dart';
import 'package:project_athens/voting_flow/data/db/vote_slim_entity.dart';

part 'athens_db.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [
  SlimDeputyVoteTypeEntity,
  VoteSlimEntity,
  SlimClubMajorityEntity,
  SpeechEntity
])
class AthensDatabase extends _$AthensDatabase {
  AthensDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

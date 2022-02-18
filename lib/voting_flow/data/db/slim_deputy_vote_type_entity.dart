import 'package:drift/drift.dart';

class SlimDeputyVoteTypeEntity extends Table {
  TextColumn get votingId => text()();
  TextColumn get deputyId => text()();
  IntColumn get type => integer()();

  @override
  Set<Column>? get primaryKey => {votingId, deputyId};
}
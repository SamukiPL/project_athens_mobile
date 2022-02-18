import 'package:drift/drift.dart';

class VoteSlimEntity extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get votingType => integer()();
  DateTimeColumn get date => dateTime()();

  IntColumn get inFavor => integer()();
  IntColumn get against => integer()();
  IntColumn get hold => integer()();
  IntColumn get absent => integer()();

  IntColumn get orderPoint => integer().nullable()();
  IntColumn get qualifyingMajority => integer().nullable()();
  IntColumn get absoluteMajority => integer().nullable()();

  BoolColumn get viewed => boolean()();

  @override
  Set<Column>? get primaryKey => {id};
}
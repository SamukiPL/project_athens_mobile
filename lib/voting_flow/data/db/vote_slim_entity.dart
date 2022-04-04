import 'package:drift/drift.dart';

class VoteSlimEntity extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get votingType => integer()();
  DateTimeColumn get date => dateTime()();
  IntColumn get deputyVoteType => integer().nullable()();

  IntColumn get inFavor => integer()();
  IntColumn get against => integer()();
  IntColumn get hold => integer()();
  IntColumn get absent => integer()();

  IntColumn get orderPoint => integer().nullable()();
  IntColumn get qualifyingMajority => integer().nullable()();
  IntColumn get absoluteMajority => integer().nullable()();

  BoolColumn get viewed => boolean()();

  /// When downloading deputy votes we need distinction which
  /// votes where downloaded for deputy and which for all otherwise
  /// we could show votes in which deputy did not vote because he was
  /// later choosen
  TextColumn get downloadedForDeputy => text().nullable()();

  @override
  Set<Column>? get primaryKey => {id};
}

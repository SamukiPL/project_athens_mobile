import 'package:drift/drift.dart';

class SpeechEntity extends Table {
  TextColumn get id => text()();
  TextColumn get personName => text()();
  TextColumn get deputyId => text().nullable()();
  TextColumn get clubId => text().nullable()();
  TextColumn get desc => text().nullable()();
  DateTimeColumn get date => dateTime()();
  TextColumn get videoUrl => text()();
  DateTimeColumn get createAt => dateTime()();
  DateTimeColumn get updateAt => dateTime()();

  IntColumn get nextDeputyCardId => integer().nullable()();
  TextColumn get nextName => text().nullable()();
  TextColumn get nextSpeechId => text().nullable()();

  IntColumn get previousDeputyCardId => integer().nullable()();
  TextColumn get previousName => text().nullable()();
  TextColumn get previousSpeechId => text().nullable()();

  BoolColumn get viewed => boolean()();

  @override
  Set<Column>? get primaryKey => {id};
}

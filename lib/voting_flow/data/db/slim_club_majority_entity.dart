import 'package:drift/drift.dart';

class SlimClubMajorityEntity extends Table {
  TextColumn get votingId => text()();
  TextColumn get parliamentClubId => text()();
  IntColumn get voteMajority => integer()();
  IntColumn get deputyCardNumber => integer()();

  @override
  Set<Column>? get primaryKey => {votingId, parliamentClubId, deputyCardNumber};
}
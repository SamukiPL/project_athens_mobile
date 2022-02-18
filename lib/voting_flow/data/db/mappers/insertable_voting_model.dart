import 'package:project_athens/athens_core/db/athens_db.dart';

class InsertableSlimVoteModel {
  final VoteSlimEntityCompanion entity;
  final List<SlimClubMajorityEntityCompanion> clubMajority;
  final List<SlimDeputyVoteTypeEntityCompanion> deputyVoteType;

  InsertableSlimVoteModel({
    required this.entity,
    required this.clubMajority,
    required this.deputyVoteType,
  });
}

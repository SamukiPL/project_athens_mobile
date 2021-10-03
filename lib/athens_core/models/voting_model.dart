import 'package:json_annotation/json_annotation.dart';
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';

class VotingModel extends TimelineModel {
  final String votingDesc;
  final String title;
  final VoteResultModel results;
  final List<VoteModel> votes;
  final int? absoluteMajority;
  final int? qualifyingMajority;
  final List<ParliamentClubVotingNumbers> clubVotes;
  final int? orderPoint;
  final VoteType? deputyVoteType;
  final VotingType votingType;

  VotingModel({
    required String id,
    required this.title,
    required DateTime date,
    required this.votingDesc,
    required this.votingType,
    required this.results,
    required this.votes,
    this.absoluteMajority,
    this.qualifyingMajority,
    required this.clubVotes,
    this.orderPoint,
    this.deputyVoteType,
    DateTime? createAt,
    DateTime? updateAt,
  }) : super(id, TimelineModelType.VOTING, date, createAt, updateAt);
}

class VoteResultModel {
  final int inFavor;
  final int against;
  final int hold;
  final int absent;

  VoteResultModel(this.inFavor, this.against, this.hold, this.absent);
}

class VoteModel {
  final VoteType type;
  final String cadencyDeputy;

  VoteModel(this.type, this.cadencyDeputy);
}

enum VoteType {
  @JsonValue(0)
  IN_FAVOR,

  @JsonValue(1)
  AGAINST,

  @JsonValue(2)
  HOLD,

  @JsonValue(3)
  ABSENT
}

import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';

class VoteNumbers {
  final int inFavor;
  final int against;
  final int hold;
  final int absent;

  VoteNumbers({this.inFavor, this.against, this.hold, this.absent});
}

class VoteSlimModel {
  final String id;
  final VotingType type;
  final DateTime voteAt;
  final VoteNumbers voteNumbers;

  VoteSlimModel({this.id, this.type, this.voteAt, this.voteNumbers});
}
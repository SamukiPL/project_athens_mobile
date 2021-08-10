import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';

class VoteNumbers {
  final int inFavor;
  final int against;
  final int hold;
  final int absent;

  VoteNumbers({this.inFavor, this.against, this.hold, this.absent});
}

class VoteSlimModel extends BaseModel {
  final String id;
  final String title;
  final VotingType type;
  final DateTime voteAt;
  final VoteNumbers voteNumbers;
  final String votingDesc;

  VoteSlimModel({this.id, this.title, this.type, this.voteAt, this.voteNumbers, this.votingDesc});
}
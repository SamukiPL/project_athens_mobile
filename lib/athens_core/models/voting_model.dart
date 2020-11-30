import 'package:project_athens/athens_core/models/timeline_model.dart';

class VotingModel extends TimelineModel {
  final String votingDesc;
  final String title;
  final VoteResultModel results;
  final List<VoteModel> votes;

  VotingModel({
    String id,
    this.title,
    DateTime date,
    this.votingDesc,
    this.results,
    this.votes
  }) : super(id, TimelineModelType.VOTING, date);
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

enum VoteType { IN_FAVOR, AGAINST, HOLD, ABSENT }
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/models/timeline_voting_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class VoteNumbers {
  final int inFavor;
  final int against;
  final int hold;
  final int absent;

  VoteNumbers({required this.inFavor, required this.against, required this.hold, required this.absent});
}

class VoteSlimClubMajority {
  final ParliamentClubModel parliamentClubModel;
  final VoteType voteMajority;
  final List<int> deputyCardNumbers;

  VoteSlimClubMajority(this.parliamentClubModel, this.voteMajority, this.deputyCardNumbers);
}

class VoteSlimDeputyVoteType {
  final SubscribedDeputyModel subscribedDeputy;
  final VoteType voteType;

  VoteSlimDeputyVoteType(this.subscribedDeputy, this.voteType);
}

class VoteSlimModel extends BaseModel {
  final String id;
  final String title;
  final VotingType type;
  final DateTime voteAt;
  final VoteNumbers voteNumbers;
  final String votingDesc;
  final int? orderPoint;
  final int? qualifyingMajority;
  final int? absoluteMajority;

  final List<VoteSlimClubMajority>? clubsMajority;
  final List<VoteSlimDeputyVoteType>? deputiesVote;

  VoteSlimModel({required this.id, required this.title, required this.type, required this.voteAt, required this.voteNumbers, required this.votingDesc, this.clubsMajority, this.deputiesVote, this.qualifyingMajority, this.absoluteMajority, this.orderPoint});

  factory VoteSlimModel.fromVotingModel(VotingModel model) {
    final voteNumbers = VoteNumbers(
      inFavor: model.results.inFavor,
      hold: model.results.hold,
      against: model.results.against,
      absent: model.results.absent
    );

    final voteSlim = new VoteSlimModel(
      id: model.id,
      title: model.title,
      type: model.votingType,
      voteAt: model.date,
      voteNumbers: voteNumbers,
      orderPoint: model.orderPoint,
      qualifyingMajority: model.qualifyingMajority,
      absoluteMajority: model.absoluteMajority,
      votingDesc: model.votingDesc
    );

    return voteSlim;
  }

  factory VoteSlimModel.fromTimelineVotingModel(TimelineVotingModel model) {
    final voteSlim = VoteSlimModel(
      id: model.id,
      absoluteMajority: model.absoluteMajority,
      qualifyingMajority: model.qualifyingMajority,
      orderPoint: model.orderPoint,
      deputiesVote: model.deputiesVote,
      clubsMajority: model.clubsMajority,
      voteNumbers: model.voteNumbers,
      voteAt: model.voteAt,
      type: model.voteType,
      votingDesc: model.votingDesc,
      title: model.title
    );

    return voteSlim;
  }

}

import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';

class LinearVoteDistributionModel {
  final int? absoluteMajority;
  final int? qualifyingMajority;

  final int inFavor;
  final int against;
  final int absent;
  final int hold;

  LinearVoteDistributionModel(
      {this.absoluteMajority, this.qualifyingMajority,
      required this.inFavor,
      required this.hold,
      required this.against,
      required this.absent});

  static LinearVoteDistributionModel fromVoteSlim(VoteSlimModel voteSlim) {
    return new LinearVoteDistributionModel(absoluteMajority: voteSlim.absoluteMajority, qualifyingMajority: voteSlim.qualifyingMajority,  inFavor: voteSlim.voteNumbers.inFavor, hold: voteSlim.voteNumbers.hold, against: voteSlim.voteNumbers.against, absent: voteSlim.voteNumbers.absent);
  }
}
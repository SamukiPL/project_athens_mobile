import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';

class LinearVoteDistributionModel {
  final int absoluteMajority;
  final int qualifyingMajority;

  final int inFavor;
  final int against;
  final int absent;
  final int hold;

  LinearVoteDistributionModel(this.absoluteMajority, this.qualifyingMajority, this.inFavor, this.hold, this.against, this.absent);

  static LinearVoteDistributionModel fromVoteSlim(VoteSlimModel voteSlim) {
    return new LinearVoteDistributionModel(voteSlim.absoluteMajority, voteSlim.qualifyingMajority, voteSlim.voteNumbers.inFavor, voteSlim.voteNumbers.hold, voteSlim.voteNumbers.against, voteSlim.voteNumbers.absent);
  }
}
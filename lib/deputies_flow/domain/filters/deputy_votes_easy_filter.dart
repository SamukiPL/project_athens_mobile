class DeputyVotesEasyFilter {
  DeputyVotesEasyFilter._();

  factory DeputyVotesEasyFilter.seen() = DeputyVoteSeenFilter;
  factory DeputyVotesEasyFilter.notSeen() = DeputyVoteNotSeenFilter;
}

class DeputyVoteSeenFilter extends DeputyVotesEasyFilter {
  DeputyVoteSeenFilter() : super._();
}

class DeputyVoteNotSeenFilter extends DeputyVotesEasyFilter {
  DeputyVoteNotSeenFilter() : super._();
}

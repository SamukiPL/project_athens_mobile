import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';

class VotesEasyFilter {
  VotesEasyFilter._();

  factory VotesEasyFilter.voteType(VotingType type) = VoteTypeFilter;
  factory VotesEasyFilter.accepted() = AcceptedVoteFilter;
  factory VotesEasyFilter.rejected() = RejectedVoteFilter;
  factory VotesEasyFilter.seen() = SeenFilter;
  factory VotesEasyFilter.notSeen() = NotSeenFilter;
}

class VoteTypeFilter extends VotesEasyFilter {
  final VotingType type;

  VoteTypeFilter(this.type): super._();
}

class AcceptedVoteFilter extends VotesEasyFilter {
  AcceptedVoteFilter() : super._();
}

class RejectedVoteFilter extends VotesEasyFilter {
  RejectedVoteFilter() : super._();
}

class SeenFilter extends VotesEasyFilter {
  SeenFilter() : super._();
}

class NotSeenFilter extends VotesEasyFilter {
  NotSeenFilter() : super._();
}

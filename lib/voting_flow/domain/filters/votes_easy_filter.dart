import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';

class VotesEasyFilter {
  VotesEasyFilter._();

  factory VotesEasyFilter.voteType(VotingType type) = VoteTypeFilter;
}

class VoteTypeFilter extends VotesEasyFilter {
  final VotingType type;

  VoteTypeFilter(this.type): super._();
}

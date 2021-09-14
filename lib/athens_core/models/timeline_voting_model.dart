import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';

class TimelineVotingModel extends TimelineModel {
  final String id;
  final String title;
  final VotingType voteType;
  final DateTime voteAt;
  final VoteNumbers voteNumbers;
  final String votingDesc;
  final int orderPoint;
  final int qualifyingMajority;
  final int absoluteMajority;

  final List<VoteSlimClubMajority> clubsMajority;
  final List<VoteSlimDeputyVoteType> deputiesVote;


  TimelineVotingModel(
      {this.id,
      this.orderPoint,
      this.title,
      this.voteType,
      this.voteAt,
      this.voteNumbers,
      this.votingDesc,
      this.qualifyingMajority,
      this.absoluteMajority,
      this.clubsMajority,
      this.deputiesVote,
      DateTime createAt,
      DateTime updateAt}) : super(id, TimelineModelType.VOTING, voteAt, createAt, updateAt);
}


extension VotingsListExtension on List<TimelineVotingModel> {

  GroupedVotingModel createGroupedVotingModel() {
    sort((a, b) => a.voteAt.compareTo(b.voteAt));
    final firstItem = first;
    final lastItem = last;
    return GroupedVotingModel(
        votingDesc: firstItem.votingDesc,
        title: firstItem.title,
        groupedVotes: this,
        firstDate: firstItem.voteAt,
        lastDate: lastItem.voteAt,
        id: firstItem.id,
        date: firstItem.voteAt
    );
  }

}
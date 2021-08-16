import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';

class VotingModel extends TimelineModel {
  final String votingDesc;
  final String title;
  final VoteResultModel results;
  final List<VoteModel> votes;
  final int? absoluteMajority;
  final int? qualifyingMajority;
  final List<ParliamentClubVotingNumbers> clubVotes;
  final int? orderPoint;
  final VoteType? deputyVoteType;

  VotingModel({
    required String id,
    required this.title,
    required DateTime date,
    required this.votingDesc,
    required this.results,
    required this.votes,
    this.absoluteMajority,
    this.qualifyingMajority,
    required this.clubVotes,
    this.orderPoint,
    this.deputyVoteType,
    DateTime? createAt,
    DateTime? updateAt,
  }) : super(id, TimelineModelType.VOTING, date, createAt, updateAt);
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

extension VotingsListExtension on List<VotingModel> {

  GroupedVotingModel createGroupedVotingModel() {
    sort((a, b) => a.date.compareTo(b.date));
    final firstItem = first;
    final lastItem = last;
    return GroupedVotingModel(
        votingDesc: firstItem.votingDesc,
        title: firstItem.title,
        groupedVotes: this,
        firstDate: firstItem.date,
        lastDate: lastItem.date,
        id: firstItem.id,
        date: firstItem.date
    );
  }

}
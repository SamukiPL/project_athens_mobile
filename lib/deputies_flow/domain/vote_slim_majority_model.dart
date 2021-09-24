import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class VoteSlimMajorityModel extends VoteSlimModel {
  final SubscribedDeputyModel desiredDeputy;
  final VoteType desiredDeputyVote;

  final ParliamentClubModel desiredClub;
  final VoteType desiredClubVote;

  VoteSlimMajorityModel({required this.desiredClub,
    required this.desiredDeputy,
    required this.desiredClubVote,
    required this.desiredDeputyVote,
    required String id,
    required VotingType type,
    required DateTime voteAt,
    required VoteNumbers voteNumbers,
    required String votingDesc,
    required String title}) : super(id: id,
      type: type,
      voteAt: voteAt,
      voteNumbers: voteNumbers,
      votingDesc: votingDesc,
      title: title);
}

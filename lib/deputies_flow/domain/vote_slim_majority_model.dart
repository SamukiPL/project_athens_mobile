import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';
import 'package:project_athens/deputies_utils/mappers/parliament_club_mapper.dart';

class VoteSlimMajorityModel extends VoteSlimModel {
  final SubscribedDeputyModel desiredDeputy;
  final VoteType desiredDeputyVote;

  final ParliamentClubModel desiredClub;
  final VoteType desiredClubVote;

  VoteSlimMajorityModel({this.desiredClub, this.desiredDeputy, this.desiredClubVote, this.desiredDeputyVote, String id, VotingType type, DateTime voteAt, VoteNumbers voteNumbers, String votingDesc, String title}) : super(id: id, type: type, voteAt: voteAt, voteNumbers: voteNumbers, votingDesc: votingDesc, title: title);
}
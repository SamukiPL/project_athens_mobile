import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

class VoteClubDistributionRowData {
  final ParliamentClubVotingNumbers votingNumbers;
  final ParliamentClubModel parliamentClubModel;

  VoteClubDistributionRowData(this.votingNumbers, this.parliamentClubModel);
}
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';

VotingType getVotingTypeFromInt(int votingType) {
  switch (votingType) {
    case 0:
      return VotingType.RESOLUTION_PROJECT;
    case 1:
      return VotingType.LAW_PROJECT;
    case 2:
      return VotingType.BREAK;
    case 3:
      return VotingType.QUORUM;
    case 4:
      return VotingType.REPORT;
    case 5:
      return VotingType.VOTE_OF_NO_CONFIDENCE;
    case 6:
      return VotingType.COMPLETION_OF_AGENDA;
    case 7:
      return VotingType.SHORTENING_DEADLINE;
    case 8:
      return VotingType.CHANGE_COMISSION_MEMBERS;
    case 9:
      return VotingType.VOTE_FOR_PROPOSAL;
  /// Pkt 19. porz. dzien. Wybór sędziów Trybunału Konstytucyjnego - głosowanie nad wyborem pana Jakuba Steliny na stanowisko sędziego Trybunału Konstytucyjnego
    case 10:
      return VotingType.PERSON_VOTE;
    case 11:
      return VotingType.VOTE_FOR_POSTPONEMENT_GATHERING;
    case 12:
      return VotingType.MARSHAL;
    case 13:
      return VotingType.VICE_MARSHAL;
    case 14:
      return VotingType.CHOOSE_COMISSION_MEMBERS;
    case 15:
      return VotingType.SELECTION_OF_PARLIAMENT_SECRETARIES;
    case 16:
      return VotingType.VOTE_OF_CONFIDENCE;
    case 17:
      return VotingType.SELECTION_OF_STATE_TRIBUNAL;
    case 18:
      return VotingType.SELECTION_OF_CONSTITUTIONAL_COURT;
    case 19:
      return VotingType.SELECTION_OF_DEPUTY_MEMBER_NATIONAL_COUNCIL_JUDICIARY;
    case 20:
      return VotingType.REPEAL_OF_REGULATION;
    case 21:
      return VotingType.RESOLUTION_OF_POINT_OF_DISPUTE;
    case 22:
      return VotingType.REQUEST_OF_REASSUMING_VOTE;
    case 23:
      return VotingType.REQUEST_OF_CLOSING_MEETING;
    case 24:
      return VotingType.PROCEED_OF_PROCEED_AGENDA;
    case 25:
      return VotingType.CHANGE_CONDUCT_OF_VOTING;
    case 26:
      return VotingType.APPOINTNMENT_MEMBER_COLLEGE_INSTITUTE_NATIONAL_REMEMBRANCE;
    case 999:
    default:
      return VotingType.UNKNOWN;
  }
}
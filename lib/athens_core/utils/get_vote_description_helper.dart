import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';

String getVoteDescriptionHelper(VotingType type, AppLocalizations _localizations) {
  switch (type) {
    case VotingType.RESOLUTION_PROJECT:
      return _localizations.getText().timelineVotingTypesResolutionProject();
    case VotingType.LAW_PROJECT:
      return _localizations.getText().timelineVotingTypesLawProject();
    case VotingType.BREAK:
      return _localizations.getText().timelineVotingTypesBreak();
    case VotingType.QUORUM:
      return _localizations.getText().timelineVotingTypesQuorum();
    case VotingType.REPORT:
      return _localizations.getText().timelineVotingTypesReport();
    case VotingType.VOTE_OF_NO_CONFIDENCE:
      return _localizations.getText().timelineVotingTypesVoteOfNoConfidence();
    case VotingType.COMPLETION_OF_AGENDA:
      return _localizations.getText().timelineVotingTypesCompletionOfAgenda();
    case VotingType.SHORTENING_DEADLINE:
      return _localizations.getText().timelineVotingTypesShorteningDeadline();
    case VotingType.CHANGE_COMISSION_MEMBERS:
      return _localizations.getText().timelineVotingTypesChangeCommissionMembers();
    case VotingType.VOTE_FOR_PROPOSAL:
      return _localizations.getText().timelineVotingTypesVoteForProposal();
    case VotingType.PERSON_VOTE:
      return _localizations.getText().timelineVotingTypesPersonVote();
    case VotingType.VOTE_FOR_POSTPONEMENT_GATHERING:
      return _localizations.getText().timelineVotingTypesVoteForPostponementGathering();
    case VotingType.MARSHAL:
      return _localizations.getText().timelineVotingTypesMarshal();
    case VotingType.VICE_MARSHAL:
      return _localizations.getText().timelineVotingTypesViceMarshal();
    case VotingType.CHOOSE_COMISSION_MEMBERS:
      return _localizations.getText().timelineVotingTypesChooseComissionMembers();
    case VotingType.SELECTION_OF_PARLIAMENT_SECRETARIES:
      return _localizations.getText().timelineVotingTypesSelectionOfParliamentSecretaries();
    case VotingType.VOTE_OF_CONFIDENCE:
      return _localizations.getText().timelineVotingTypesVoteOfConfidence();
    case VotingType.SELECTION_OF_STATE_TRIBUNAL:
      return _localizations.getText().timelineVotingTypesSelectionOfStateTribunal();
    case VotingType.SELECTION_OF_CONSTITUTIONAL_COURT:
      return _localizations.getText().timelineVotingTypesSelectionOfConstitutionalCourt();
    case VotingType.SELECTION_OF_DEPUTY_MEMBER_NATIONAL_COUNCIL_JUDICIARY:
      return _localizations.getText().timelineVotingTypesSelectionOfNationalCouncilJudiciary();
    case VotingType.REPEAL_OF_REGULATION:
      return _localizations.getText().timelineVotingTypesRepealOfRegulation();
    case VotingType.RESOLUTION_OF_POINT_OF_DISPUTE:
      return _localizations.getText().timelineVotingTypesResolutionOfPointOfDispute();
    case VotingType.REQUEST_OF_REASSUMING_VOTE:
      return _localizations.getText().timelineVotingTypesRequestOfReassumingVote();
    case VotingType.REQUEST_OF_CLOSING_MEETING:
      return _localizations.getText().timelineVotingTypesRequestOfClosingMeeting();
    case VotingType.PROCEED_OF_PROCEED_AGENDA:
      return _localizations.getText().timelineVotingTypesProceedOfProceedAgenda();
    case VotingType.CHANGE_CONDUCT_OF_VOTING:
      return _localizations.getText().timelineVotingTypesChangeConductOfVoting();
    case VotingType.APPOINTNMENT_MEMBER_COLLEGE_INSTITUTE_NATIONAL_REMEMBRANCE:
      return _localizations.getText().timelineVotingTypesAppointmentMemberCollegeInstituteNationalRemembrance();
    case VotingType.UNKNOWN:
      return _localizations.getText().timelineVotingTypesUnknown();
    default:
      throw Exception("There is no other VotingType!");
  }
}

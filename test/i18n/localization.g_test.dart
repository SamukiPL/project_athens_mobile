import 'dart:convert';
import 'dart:io';

import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String scriptPath = Platform.script.path;
  String osPrefix = Platform.isLinux || Platform.isMacOS ? '/' : '';
  String filePathForCoverage = osPrefix + scriptPath.substring(0, scriptPath.indexOf('main.dart')).substring(1) + 'resources/lang/';

  File enFile = File(filePathForCoverage + 'en.json');
  String enData = enFile.readAsStringSync();
  Map<String, dynamic> enWords = json.decode(enData);
  testAllMethods('en', AppLocalizationsGenerated(enWords));

  File plFile = File(filePathForCoverage + 'pl.json');
  String plData = plFile.readAsStringSync();
  Map<String, dynamic> plWords = json.decode(plData);
  testAllMethods('pl', AppLocalizationsGenerated(plWords));
}

void testAllMethods(String locale, AppLocalizationsGenerated localization) {
  test("All methods for $locale universalBack", () async {
    String universalBack = localization.universalBack();
    expect(true, universalBack != ""); 
  }); 
 
  test("All methods for $locale universalNext", () async {
    String universalNext = localization.universalNext();
    expect(true, universalNext != ""); 
  }); 
 
  test("All methods for $locale universalCancel", () async {
    String universalCancel = localization.universalCancel();
    expect(true, universalCancel != ""); 
  }); 
 
  test("All methods for $locale universalSkip", () async {
    String universalSkip = localization.universalSkip();
    expect(true, universalSkip != ""); 
  }); 
 
  test("All methods for $locale universalChoose", () async {
    String universalChoose = localization.universalChoose();
    expect(true, universalChoose != ""); 
  }); 
 
  test("All methods for $locale universalOk", () async {
    String universalOk = localization.universalOk();
    expect(true, universalOk != ""); 
  }); 
 
  test("All methods for $locale universalAccept", () async {
    String universalAccept = localization.universalAccept();
    expect(true, universalAccept != ""); 
  }); 
 
  test("All methods for $locale universalRefresh", () async {
    String universalRefresh = localization.universalRefresh();
    expect(true, universalRefresh != ""); 
  }); 
 
  test("All methods for $locale universalNewDataAvailable", () async {
    String universalNewDataAvailable = localization.universalNewDataAvailable();
    expect(true, universalNewDataAvailable != ""); 
  }); 
 
  test("All methods for $locale universalRetry", () async {
    String universalRetry = localization.universalRetry();
    expect(true, universalRetry != ""); 
  }); 
 
  test("All methods for $locale universalClose", () async {
    String universalClose = localization.universalClose();
    expect(true, universalClose != ""); 
  }); 
 
  test("All methods for $locale universalDownloadingData", () async {
    String universalDownloadingData = localization.universalDownloadingData();
    expect(true, universalDownloadingData != ""); 
  }); 
 
  test("All methods for $locale universalGoToLogin", () async {
    String universalGoToLogin = localization.universalGoToLogin();
    expect(true, universalGoToLogin != ""); 
  }); 
 
  test("All methods for $locale universalSuccess", () async {
    String universalSuccess = localization.universalSuccess();
    expect(true, universalSuccess != ""); 
  }); 
 
  test("All methods for $locale universalNoDataDefaultText", () async {
    String universalNoDataDefaultText = localization.universalNoDataDefaultText();
    expect(true, universalNoDataDefaultText != ""); 
  }); 
 
  test("All methods for $locale universalNoDataNoInformation", () async {
    String universalNoDataNoInformation = localization.universalNoDataNoInformation();
    expect(true, universalNoDataNoInformation != ""); 
  }); 
 
  test("All methods for $locale universalAgreementOrTryToOpenInBrowser", () async {
    String universalAgreementOrTryToOpenInBrowser = localization.universalAgreementOrTryToOpenInBrowser();
    expect(true, universalAgreementOrTryToOpenInBrowser != ""); 
  }); 
 
  test("All methods for $locale universalAgreementYouMustAgreeOnTermsAndConditions", () async {
    String universalAgreementYouMustAgreeOnTermsAndConditions = localization.universalAgreementYouMustAgreeOnTermsAndConditions();
    expect(true, universalAgreementYouMustAgreeOnTermsAndConditions != ""); 
  }); 
 
  test("All methods for $locale universalAgreementTitle", () async {
    String universalAgreementTitle = localization.universalAgreementTitle();
    expect(true, universalAgreementTitle != ""); 
  }); 
 
  test("All methods for $locale universalAgreementIAgree", () async {
    String universalAgreementIAgree = localization.universalAgreementIAgree();
    expect(true, universalAgreementIAgree != ""); 
  }); 
 
  test("All methods for $locale universalAgreementTermsAndConditions", () async {
    String universalAgreementTermsAndConditions = localization.universalAgreementTermsAndConditions();
    expect(true, universalAgreementTermsAndConditions != ""); 
  }); 
 
  test("All methods for $locale universalInformation", () async {
    String universalInformation = localization.universalInformation();
    expect(true, universalInformation != ""); 
  }); 
 
  test("All methods for $locale universalExperimentalFeatureContent", () async {
    String universalExperimentalFeatureContent = localization.universalExperimentalFeatureContent();
    expect(true, universalExperimentalFeatureContent != ""); 
  }); 
 
  test("All methods for $locale universalExperimentalFeatureTitle", () async {
    String universalExperimentalFeatureTitle = localization.universalExperimentalFeatureTitle();
    expect(true, universalExperimentalFeatureTitle != ""); 
  }); 
 
  test("All methods for $locale universalErrorJustError", () async {
    String universalErrorJustError = localization.universalErrorJustError();
    expect(true, universalErrorJustError != ""); 
  }); 
 
  test("All methods for $locale universalErrorNetwork", () async {
    String universalErrorNetwork = localization.universalErrorNetwork();
    expect(true, universalErrorNetwork != ""); 
  }); 
 
  test("All methods for $locale universalErrorServer", () async {
    String universalErrorServer = localization.universalErrorServer();
    expect(true, universalErrorServer != ""); 
  }); 
 
  test("All methods for $locale universalErrorAuth", () async {
    String universalErrorAuth = localization.universalErrorAuth();
    expect(true, universalErrorAuth != ""); 
  }); 
 
  test("All methods for $locale universalErrorUnknown", () async {
    String universalErrorUnknown = localization.universalErrorUnknown();
    expect(true, universalErrorUnknown != ""); 
  }); 
 
  test("All methods for $locale universalSource", () async {
    String universalSource = localization.universalSource();
    expect(true, universalSource != ""); 
  }); 
 
  test("All methods for $locale universalCreatedAt", () async {
    String universalCreatedAt = localization.universalCreatedAt();
    expect(true, universalCreatedAt != ""); 
  }); 
 
  test("All methods for $locale universalUpdatedAt", () async {
    String universalUpdatedAt = localization.universalUpdatedAt();
    expect(true, universalUpdatedAt != ""); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogTitle", () async {
    String universalUpdateCupertinoDialogTitle = localization.universalUpdateCupertinoDialogTitle();
    expect(true, universalUpdateCupertinoDialogTitle != ""); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogButtonIgnore", () async {
    String universalUpdateCupertinoDialogButtonIgnore = localization.universalUpdateCupertinoDialogButtonIgnore();
    expect(true, universalUpdateCupertinoDialogButtonIgnore != ""); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogButtonLater", () async {
    String universalUpdateCupertinoDialogButtonLater = localization.universalUpdateCupertinoDialogButtonLater();
    expect(true, universalUpdateCupertinoDialogButtonLater != ""); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogButtonUpdateNow", () async {
    String universalUpdateCupertinoDialogButtonUpdateNow = localization.universalUpdateCupertinoDialogButtonUpdateNow();
    expect(true, universalUpdateCupertinoDialogButtonUpdateNow != ""); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow", () async {
    String universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow = localization.universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow();
    expect(true, universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow != ""); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogImmediateUpdateTitle", () async {
    String universalUpdateCupertinoDialogImmediateUpdateTitle = localization.universalUpdateCupertinoDialogImmediateUpdateTitle();
    expect(true, universalUpdateCupertinoDialogImmediateUpdateTitle != ""); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogImmediateUpdateContent", () async {
    String universalUpdateCupertinoDialogImmediateUpdateContent = localization.universalUpdateCupertinoDialogImmediateUpdateContent();
    expect(true, universalUpdateCupertinoDialogImmediateUpdateContent != ""); 
  }); 
 
  test("All methods for $locale universalSeen", () async {
    String universalSeen = localization.universalSeen();
    expect(true, universalSeen != ""); 
  }); 
 
  test("All methods for $locale universalNotSeen", () async {
    String universalNotSeen = localization.universalNotSeen();
    expect(true, universalNotSeen != ""); 
  }); 
 
  test("All methods for $locale mainMenuSession", () async {
    String mainMenuSession = localization.mainMenuSession();
    expect(true, mainMenuSession != ""); 
  }); 
 
  test("All methods for $locale mainMenuMusic", () async {
    String mainMenuMusic = localization.mainMenuMusic();
    expect(true, mainMenuMusic != ""); 
  }); 
 
  test("All methods for $locale mainMenuMaterials", () async {
    String mainMenuMaterials = localization.mainMenuMaterials();
    expect(true, mainMenuMaterials != ""); 
  }); 
 
  test("All methods for $locale mainMenuCharactersCards", () async {
    String mainMenuCharactersCards = localization.mainMenuCharactersCards();
    expect(true, mainMenuCharactersCards != ""); 
  }); 
 
  test("All methods for $locale mainMenuActiveSessions", () async {
    String mainMenuActiveSessions = localization.mainMenuActiveSessions();
    expect(true, mainMenuActiveSessions != ""); 
  }); 
 
  test("All methods for $locale mainMenuSurveys", () async {
    String mainMenuSurveys = localization.mainMenuSurveys();
    expect(true, mainMenuSurveys != ""); 
  }); 
 
  test("All methods for $locale mainMenuSystems", () async {
    String mainMenuSystems = localization.mainMenuSystems();
    expect(true, mainMenuSystems != ""); 
  }); 
 
  test("All methods for $locale loginButtonsLogin", () async {
    String loginButtonsLogin = localization.loginButtonsLogin();
    expect(true, loginButtonsLogin != ""); 
  }); 
 
  test("All methods for $locale loginButtonsRegister", () async {
    String loginButtonsRegister = localization.loginButtonsRegister();
    expect(true, loginButtonsRegister != ""); 
  }); 
 
  test("All methods for $locale loginButtonsForgot", () async {
    String loginButtonsForgot = localization.loginButtonsForgot();
    expect(true, loginButtonsForgot != ""); 
  }); 
 
  test("All methods for $locale loginButtonsSignUp", () async {
    String loginButtonsSignUp = localization.loginButtonsSignUp();
    expect(true, loginButtonsSignUp != ""); 
  }); 
 
  test("All methods for $locale loginButtonsResetPassword", () async {
    String loginButtonsResetPassword = localization.loginButtonsResetPassword();
    expect(true, loginButtonsResetPassword != ""); 
  }); 
 
  test("All methods for $locale loginButtonsContinueWithoutSignIn", () async {
    String loginButtonsContinueWithoutSignIn = localization.loginButtonsContinueWithoutSignIn();
    expect(true, loginButtonsContinueWithoutSignIn != ""); 
  }); 
 
  test("All methods for $locale loginHintsEmail", () async {
    String loginHintsEmail = localization.loginHintsEmail();
    expect(true, loginHintsEmail != ""); 
  }); 
 
  test("All methods for $locale loginHintsRepeatEmail", () async {
    String loginHintsRepeatEmail = localization.loginHintsRepeatEmail();
    expect(true, loginHintsRepeatEmail != ""); 
  }); 
 
  test("All methods for $locale loginHintsLogin", () async {
    String loginHintsLogin = localization.loginHintsLogin();
    expect(true, loginHintsLogin != ""); 
  }); 
 
  test("All methods for $locale loginHintsLoginOrEmail", () async {
    String loginHintsLoginOrEmail = localization.loginHintsLoginOrEmail();
    expect(true, loginHintsLoginOrEmail != ""); 
  }); 
 
  test("All methods for $locale loginHintsName", () async {
    String loginHintsName = localization.loginHintsName();
    expect(true, loginHintsName != ""); 
  }); 
 
  test("All methods for $locale loginHintsPassword", () async {
    String loginHintsPassword = localization.loginHintsPassword();
    expect(true, loginHintsPassword != ""); 
  }); 
 
  test("All methods for $locale loginHintsRepeatPassword", () async {
    String loginHintsRepeatPassword = localization.loginHintsRepeatPassword();
    expect(true, loginHintsRepeatPassword != ""); 
  }); 
 
  test("All methods for $locale loginHintsFirstName", () async {
    String loginHintsFirstName = localization.loginHintsFirstName();
    expect(true, loginHintsFirstName != ""); 
  }); 
 
  test("All methods for $locale loginHintsLastName", () async {
    String loginHintsLastName = localization.loginHintsLastName();
    expect(true, loginHintsLastName != ""); 
  }); 
 
  test("All methods for $locale loginOtherForgotRationale", () async {
    String loginOtherForgotRationale = localization.loginOtherForgotRationale();
    expect(true, loginOtherForgotRationale != ""); 
  }); 
 
  test("All methods for $locale loginOtherFacebook", () async {
    String loginOtherFacebook = localization.loginOtherFacebook();
    expect(true, loginOtherFacebook != ""); 
  }); 
 
  test("All methods for $locale loginOtherTwitter", () async {
    String loginOtherTwitter = localization.loginOtherTwitter();
    expect(true, loginOtherTwitter != ""); 
  }); 
 
  test("All methods for $locale loginOtherGoogle", () async {
    String loginOtherGoogle = localization.loginOtherGoogle();
    expect(true, loginOtherGoogle != ""); 
  }); 
 
  test("All methods for $locale loginOtherNotAMember", () async {
    String loginOtherNotAMember = localization.loginOtherNotAMember();
    expect(true, loginOtherNotAMember != ""); 
  }); 
 
  test("All methods for $locale loginOtherConnectWith", () async {
    String loginOtherConnectWith = localization.loginOtherConnectWith();
    expect(true, loginOtherConnectWith != ""); 
  }); 
 
  test("All methods for $locale loginOtherIfAccountExistEmailIsSent", () async {
    String loginOtherIfAccountExistEmailIsSent = localization.loginOtherIfAccountExistEmailIsSent();
    expect(true, loginOtherIfAccountExistEmailIsSent != ""); 
  }); 
 
  test("All methods for $locale loginValidateFieldCannotBeEmpty", () async {
    String loginValidateFieldCannotBeEmpty = localization.loginValidateFieldCannotBeEmpty();
    expect(true, loginValidateFieldCannotBeEmpty != ""); 
  }); 
 
  test("All methods for $locale loginValidateIncorrectEmail", () async {
    String loginValidateIncorrectEmail = localization.loginValidateIncorrectEmail();
    expect(true, loginValidateIncorrectEmail != ""); 
  }); 
 
  test("All methods for $locale loginValidateLoginIsTaken", () async {
    String loginValidateLoginIsTaken = localization.loginValidateLoginIsTaken();
    expect(true, loginValidateLoginIsTaken != ""); 
  }); 
 
  test("All methods for $locale loginValidateLoginIsInvalid", () async {
    String loginValidateLoginIsInvalid = localization.loginValidateLoginIsInvalid();
    expect(true, loginValidateLoginIsInvalid != ""); 
  }); 
 
  test("All methods for $locale loginValidateEmailIsTaken", () async {
    String loginValidateEmailIsTaken = localization.loginValidateEmailIsTaken();
    expect(true, loginValidateEmailIsTaken != ""); 
  }); 
 
  test("All methods for $locale loginValidateEmailsDontMatch", () async {
    String loginValidateEmailsDontMatch = localization.loginValidateEmailsDontMatch();
    expect(true, loginValidateEmailsDontMatch != ""); 
  }); 
 
  test("All methods for $locale loginValidatePasswordsDontMatch", () async {
    String loginValidatePasswordsDontMatch = localization.loginValidatePasswordsDontMatch();
    expect(true, loginValidatePasswordsDontMatch != ""); 
  }); 
 
  test("All methods for $locale loginValidateWrongData", () async {
    String loginValidateWrongData = localization.loginValidateWrongData();
    expect(true, loginValidateWrongData != ""); 
  }); 
 
  test("All methods for $locale loginErrorPasswordOrLoginDoesNotMatch", () async {
    String loginErrorPasswordOrLoginDoesNotMatch = localization.loginErrorPasswordOrLoginDoesNotMatch();
    expect(true, loginErrorPasswordOrLoginDoesNotMatch != ""); 
  }); 
 
  test("All methods for $locale timelineVote", () async {
    String timelineVote = localization.timelineVote();
    expect(true, timelineVote != ""); 
  }); 
 
  test("All methods for $locale timelineVoteNoAgenda", () async {
    String timelineVoteNoAgenda = localization.timelineVoteNoAgenda();
    expect(true, timelineVoteNoAgenda != ""); 
  }); 
 
  test("All methods for $locale timelineTimelineNavTitle", () async {
    String timelineTimelineNavTitle = localization.timelineTimelineNavTitle();
    expect(true, timelineTimelineNavTitle != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesResolutionProject", () async {
    String timelineVotingTypesResolutionProject = localization.timelineVotingTypesResolutionProject();
    expect(true, timelineVotingTypesResolutionProject != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesLawProject", () async {
    String timelineVotingTypesLawProject = localization.timelineVotingTypesLawProject();
    expect(true, timelineVotingTypesLawProject != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesBreak", () async {
    String timelineVotingTypesBreak = localization.timelineVotingTypesBreak();
    expect(true, timelineVotingTypesBreak != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesQuorum", () async {
    String timelineVotingTypesQuorum = localization.timelineVotingTypesQuorum();
    expect(true, timelineVotingTypesQuorum != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesReport", () async {
    String timelineVotingTypesReport = localization.timelineVotingTypesReport();
    expect(true, timelineVotingTypesReport != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesVoteOfNoConfidence", () async {
    String timelineVotingTypesVoteOfNoConfidence = localization.timelineVotingTypesVoteOfNoConfidence();
    expect(true, timelineVotingTypesVoteOfNoConfidence != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesCompletionOfAgenda", () async {
    String timelineVotingTypesCompletionOfAgenda = localization.timelineVotingTypesCompletionOfAgenda();
    expect(true, timelineVotingTypesCompletionOfAgenda != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesShorteningDeadline", () async {
    String timelineVotingTypesShorteningDeadline = localization.timelineVotingTypesShorteningDeadline();
    expect(true, timelineVotingTypesShorteningDeadline != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesChangeCommissionMembers", () async {
    String timelineVotingTypesChangeCommissionMembers = localization.timelineVotingTypesChangeCommissionMembers();
    expect(true, timelineVotingTypesChangeCommissionMembers != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesVoteForProposal", () async {
    String timelineVotingTypesVoteForProposal = localization.timelineVotingTypesVoteForProposal();
    expect(true, timelineVotingTypesVoteForProposal != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesPersonVote", () async {
    String timelineVotingTypesPersonVote = localization.timelineVotingTypesPersonVote();
    expect(true, timelineVotingTypesPersonVote != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesVoteForPostponementGathering", () async {
    String timelineVotingTypesVoteForPostponementGathering = localization.timelineVotingTypesVoteForPostponementGathering();
    expect(true, timelineVotingTypesVoteForPostponementGathering != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesMarshal", () async {
    String timelineVotingTypesMarshal = localization.timelineVotingTypesMarshal();
    expect(true, timelineVotingTypesMarshal != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesViceMarshal", () async {
    String timelineVotingTypesViceMarshal = localization.timelineVotingTypesViceMarshal();
    expect(true, timelineVotingTypesViceMarshal != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesChooseComissionMembers", () async {
    String timelineVotingTypesChooseComissionMembers = localization.timelineVotingTypesChooseComissionMembers();
    expect(true, timelineVotingTypesChooseComissionMembers != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesSelectionOfParliamentSecretaries", () async {
    String timelineVotingTypesSelectionOfParliamentSecretaries = localization.timelineVotingTypesSelectionOfParliamentSecretaries();
    expect(true, timelineVotingTypesSelectionOfParliamentSecretaries != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesVoteOfConfidence", () async {
    String timelineVotingTypesVoteOfConfidence = localization.timelineVotingTypesVoteOfConfidence();
    expect(true, timelineVotingTypesVoteOfConfidence != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesSelectionOfStateTribunal", () async {
    String timelineVotingTypesSelectionOfStateTribunal = localization.timelineVotingTypesSelectionOfStateTribunal();
    expect(true, timelineVotingTypesSelectionOfStateTribunal != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesSelectionOfConstitutionalCourt", () async {
    String timelineVotingTypesSelectionOfConstitutionalCourt = localization.timelineVotingTypesSelectionOfConstitutionalCourt();
    expect(true, timelineVotingTypesSelectionOfConstitutionalCourt != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesSelectionOfNationalCouncilJudiciary", () async {
    String timelineVotingTypesSelectionOfNationalCouncilJudiciary = localization.timelineVotingTypesSelectionOfNationalCouncilJudiciary();
    expect(true, timelineVotingTypesSelectionOfNationalCouncilJudiciary != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesRepealOfRegulation", () async {
    String timelineVotingTypesRepealOfRegulation = localization.timelineVotingTypesRepealOfRegulation();
    expect(true, timelineVotingTypesRepealOfRegulation != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesResolutionOfPointOfDispute", () async {
    String timelineVotingTypesResolutionOfPointOfDispute = localization.timelineVotingTypesResolutionOfPointOfDispute();
    expect(true, timelineVotingTypesResolutionOfPointOfDispute != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesRequestOfReassumingVote", () async {
    String timelineVotingTypesRequestOfReassumingVote = localization.timelineVotingTypesRequestOfReassumingVote();
    expect(true, timelineVotingTypesRequestOfReassumingVote != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesRequestOfClosingMeeting", () async {
    String timelineVotingTypesRequestOfClosingMeeting = localization.timelineVotingTypesRequestOfClosingMeeting();
    expect(true, timelineVotingTypesRequestOfClosingMeeting != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesProceedOfProceedAgenda", () async {
    String timelineVotingTypesProceedOfProceedAgenda = localization.timelineVotingTypesProceedOfProceedAgenda();
    expect(true, timelineVotingTypesProceedOfProceedAgenda != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesChangeConductOfVoting", () async {
    String timelineVotingTypesChangeConductOfVoting = localization.timelineVotingTypesChangeConductOfVoting();
    expect(true, timelineVotingTypesChangeConductOfVoting != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesAppointmentMemberCollegeInstituteNationalRemembrance", () async {
    String timelineVotingTypesAppointmentMemberCollegeInstituteNationalRemembrance = localization.timelineVotingTypesAppointmentMemberCollegeInstituteNationalRemembrance();
    expect(true, timelineVotingTypesAppointmentMemberCollegeInstituteNationalRemembrance != ""); 
  }); 
 
  test("All methods for $locale timelineVotingTypesUnknown", () async {
    String timelineVotingTypesUnknown = localization.timelineVotingTypesUnknown();
    expect(true, timelineVotingTypesUnknown != ""); 
  }); 
 
  test("All methods for $locale timelineNounCloudNoNouns", () async {
    String timelineNounCloudNoNouns = localization.timelineNounCloudNoNouns();
    expect(true, timelineNounCloudNoNouns != ""); 
  }); 
 
  test("All methods for $locale timelineNoEvents", () async {
    String timelineNoEvents = localization.timelineNoEvents();
    expect(true, timelineNoEvents != ""); 
  }); 
 
  test("All methods for $locale deputiesDeputiesListTitle", () async {
    String deputiesDeputiesListTitle = localization.deputiesDeputiesListTitle();
    expect(true, deputiesDeputiesListTitle != ""); 
  }); 
 
  test("All methods for $locale deputiesInformation", () async {
    String deputiesInformation = localization.deputiesInformation();
    expect(true, deputiesInformation != ""); 
  }); 
 
  test("All methods for $locale deputiesSpeeches", () async {
    String deputiesSpeeches = localization.deputiesSpeeches();
    expect(true, deputiesSpeeches != ""); 
  }); 
 
  test("All methods for $locale deputiesVotings", () async {
    String deputiesVotings = localization.deputiesVotings();
    expect(true, deputiesVotings != ""); 
  }); 
 
  test("All methods for $locale deputiesBirthDate", () async {
    String deputiesBirthDate = localization.deputiesBirthDate();
    expect(true, deputiesBirthDate != ""); 
  }); 
 
  test("All methods for $locale deputiesEducation", () async {
    String deputiesEducation = localization.deputiesEducation();
    expect(true, deputiesEducation != ""); 
  }); 
 
  test("All methods for $locale deputiesProfession", () async {
    String deputiesProfession = localization.deputiesProfession();
    expect(true, deputiesProfession != ""); 
  }); 
 
  test("All methods for $locale deputiesFinishedSchools", () async {
    String deputiesFinishedSchools = localization.deputiesFinishedSchools();
    expect(true, deputiesFinishedSchools != ""); 
  }); 
 
  test("All methods for $locale deputiesParliamentExperience", () async {
    String deputiesParliamentExperience = localization.deputiesParliamentExperience();
    expect(true, deputiesParliamentExperience != ""); 
  }); 
 
  test("All methods for $locale deputiesNoHighestAccuracy", () async {
    String deputiesNoHighestAccuracy = localization.deputiesNoHighestAccuracy();
    expect(true, deputiesNoHighestAccuracy != ""); 
  }); 
 
  test("All methods for $locale deputiesSpeechCounter", () async {
    String deputiesSpeechCounter = localization.deputiesSpeechCounter();
    expect(true, deputiesSpeechCounter != ""); 
  }); 
 
  test("All methods for $locale deputiesVoteAbsency", () async {
    String deputiesVoteAbsency = localization.deputiesVoteAbsency();
    expect(true, deputiesVoteAbsency != ""); 
  }); 
 
  test("All methods for $locale deputiesMostAccuracy", () async {
    String deputiesMostAccuracy = localization.deputiesMostAccuracy();
    expect(true, deputiesMostAccuracy != ""); 
  }); 
 
  test("All methods for $locale deputiesVoteAccuracy", () async {
    String deputiesVoteAccuracy = localization.deputiesVoteAccuracy();
    expect(true, deputiesVoteAccuracy != ""); 
  }); 
 
  test("All methods for $locale deputiesAlignedWithParty", () async {
    String deputiesAlignedWithParty = localization.deputiesAlignedWithParty();
    expect(true, deputiesAlignedWithParty != ""); 
  }); 
 
  test("All methods for $locale deputiesNotAlignedWithParty", () async {
    String deputiesNotAlignedWithParty = localization.deputiesNotAlignedWithParty();
    expect(true, deputiesNotAlignedWithParty != ""); 
  }); 
 
  test("All methods for $locale deputiesBasicInfo", () async {
    String deputiesBasicInfo = localization.deputiesBasicInfo();
    expect(true, deputiesBasicInfo != ""); 
  }); 
 
  test("All methods for $locale deputiesExperience", () async {
    String deputiesExperience = localization.deputiesExperience();
    expect(true, deputiesExperience != ""); 
  }); 
 
  test("All methods for $locale deputiesStatistics", () async {
    String deputiesStatistics = localization.deputiesStatistics();
    expect(true, deputiesStatistics != ""); 
  }); 
 
  test("All methods for $locale deputiesStatisticsInfo", () async {
    String deputiesStatisticsInfo = localization.deputiesStatisticsInfo();
    expect(true, deputiesStatisticsInfo != ""); 
  }); 
 
  test("All methods for $locale deputiesWordCloud", () async {
    String deputiesWordCloud = localization.deputiesWordCloud();
    expect(true, deputiesWordCloud != ""); 
  }); 
 
  test("All methods for $locale deputiesWordCloudInfo", () async {
    String deputiesWordCloudInfo = localization.deputiesWordCloudInfo();
    expect(true, deputiesWordCloudInfo != ""); 
  }); 
 
  test("All methods for $locale deputiesSubscribe", () async {
    String deputiesSubscribe = localization.deputiesSubscribe();
    expect(true, deputiesSubscribe != ""); 
  }); 
 
  test("All methods for $locale deputiesNotSubscribingDeputy", () async {
    String deputiesNotSubscribingDeputy = localization.deputiesNotSubscribingDeputy();
    expect(true, deputiesNotSubscribingDeputy != ""); 
  }); 
 
  test("All methods for $locale deputiesSubscribingDeputy", () async {
    String deputiesSubscribingDeputy = localization.deputiesSubscribingDeputy();
    expect(true, deputiesSubscribingDeputy != ""); 
  }); 
 
  test("All methods for $locale speechesSpeechesListTitle", () async {
    String speechesSpeechesListTitle = localization.speechesSpeechesListTitle();
    expect(true, speechesSpeechesListTitle != ""); 
  }); 
 
  test("All methods for $locale speechesSpeechDetailsTitle", () async {
    String speechesSpeechDetailsTitle = localization.speechesSpeechDetailsTitle();
    expect(true, speechesSpeechDetailsTitle != ""); 
  }); 
 
  test("All methods for $locale speechesNoData", () async {
    String speechesNoData = localization.speechesNoData();
    expect(true, speechesNoData != ""); 
  }); 
 
  test("All methods for $locale speechesPreviousSpeech", () async {
    String speechesPreviousSpeech = localization.speechesPreviousSpeech();
    expect(true, speechesPreviousSpeech != ""); 
  }); 
 
  test("All methods for $locale speechesNextSpeech", () async {
    String speechesNextSpeech = localization.speechesNextSpeech();
    expect(true, speechesNextSpeech != ""); 
  }); 
 
  test("All methods for $locale speechesPlayNow", () async {
    String speechesPlayNow = localization.speechesPlayNow();
    expect(true, speechesPlayNow != ""); 
  }); 
 
  test("All methods for $locale votingsVotingListTitle", () async {
    String votingsVotingListTitle = localization.votingsVotingListTitle();
    expect(true, votingsVotingListTitle != ""); 
  }); 
 
  test("All methods for $locale votingsVoteTypesTotalDeputiesPlural", () async {
    String votingsVoteTypesTotalDeputiesPlural = localization.votingsVoteTypesTotalDeputiesPlural();
    expect(true, votingsVoteTypesTotalDeputiesPlural != ""); 
  }); 
 
  test("All methods for $locale votingsVoteTypesActualVotedDeputiesPlural", () async {
    String votingsVoteTypesActualVotedDeputiesPlural = localization.votingsVoteTypesActualVotedDeputiesPlural();
    expect(true, votingsVoteTypesActualVotedDeputiesPlural != ""); 
  }); 
 
  test("All methods for $locale votingsVoteTypesInFavorSingle", () async {
    String votingsVoteTypesInFavorSingle = localization.votingsVoteTypesInFavorSingle();
    expect(true, votingsVoteTypesInFavorSingle != ""); 
  }); 
 
  test("All methods for $locale votingsVoteTypesInFavor", () async {
    String votingsVoteTypesInFavor = localization.votingsVoteTypesInFavor();
    expect(true, votingsVoteTypesInFavor != ""); 
  }); 
 
  test("All methods for $locale votingsVoteTypesAgainstSingle", () async {
    String votingsVoteTypesAgainstSingle = localization.votingsVoteTypesAgainstSingle();
    expect(true, votingsVoteTypesAgainstSingle != ""); 
  }); 
 
  test("All methods for $locale votingsVoteTypesAgainst", () async {
    String votingsVoteTypesAgainst = localization.votingsVoteTypesAgainst();
    expect(true, votingsVoteTypesAgainst != ""); 
  }); 
 
  test("All methods for $locale votingsVoteTypesHoldPlural", () async {
    String votingsVoteTypesHoldPlural = localization.votingsVoteTypesHoldPlural();
    expect(true, votingsVoteTypesHoldPlural != ""); 
  }); 
 
  test("All methods for $locale votingsVoteTypesAbsentPlural", () async {
    String votingsVoteTypesAbsentPlural = localization.votingsVoteTypesAbsentPlural();
    expect(true, votingsVoteTypesAbsentPlural != ""); 
  }); 
 
  test("All methods for $locale votingsVoteTypesHoldSingle", () async {
    String votingsVoteTypesHoldSingle = localization.votingsVoteTypesHoldSingle();
    expect(true, votingsVoteTypesHoldSingle != ""); 
  }); 
 
  test("All methods for $locale votingsVoteTypesAbsentSingle", () async {
    String votingsVoteTypesAbsentSingle = localization.votingsVoteTypesAbsentSingle();
    expect(true, votingsVoteTypesAbsentSingle != ""); 
  }); 
 
  test("All methods for $locale votingsFiltersAccepted", () async {
    String votingsFiltersAccepted = localization.votingsFiltersAccepted();
    expect(true, votingsFiltersAccepted != ""); 
  }); 
 
  test("All methods for $locale votingsFiltersRejected", () async {
    String votingsFiltersRejected = localization.votingsFiltersRejected();
    expect(true, votingsFiltersRejected != ""); 
  }); 
 
  test("All methods for $locale votingsSubscribedDeputiesVotes", () async {
    String votingsSubscribedDeputiesVotes = localization.votingsSubscribedDeputiesVotes();
    expect(true, votingsSubscribedDeputiesVotes != ""); 
  }); 
 
  test("All methods for $locale votingsVotesNeededToPass", () async {
    String votingsVotesNeededToPass = localization.votingsVotesNeededToPass();
    expect(true, votingsVotesNeededToPass != ""); 
  }); 
 
  test("All methods for $locale votingsNoData", () async {
    String votingsNoData = localization.votingsNoData();
    expect(true, votingsNoData != ""); 
  }); 
 
  test("All methods for $locale moreTitle", () async {
    String moreTitle = localization.moreTitle();
    expect(true, moreTitle != ""); 
  }); 
 
  test("All methods for $locale moreUser", () async {
    String moreUser = localization.moreUser();
    expect(true, moreUser != ""); 
  }); 
 
  test("All methods for $locale moreGoToSettings", () async {
    String moreGoToSettings = localization.moreGoToSettings();
    expect(true, moreGoToSettings != ""); 
  }); 
 
  test("All methods for $locale moreLikeApplication", () async {
    String moreLikeApplication = localization.moreLikeApplication();
    expect(true, moreLikeApplication != ""); 
  }); 
 
  test("All methods for $locale moreSupportUs", () async {
    String moreSupportUs = localization.moreSupportUs();
    expect(true, moreSupportUs != ""); 
  }); 
 
  test("All methods for $locale moreCheckForUpdates", () async {
    String moreCheckForUpdates = localization.moreCheckForUpdates();
    expect(true, moreCheckForUpdates != ""); 
  }); 
 
  test("All methods for $locale moreAppVersion", () async {
    String moreAppVersion = localization.moreAppVersion();
    expect(true, moreAppVersion != ""); 
  }); 
 
  test("All methods for $locale moreTermsAndAgreement", () async {
    String moreTermsAndAgreement = localization.moreTermsAndAgreement();
    expect(true, moreTermsAndAgreement != ""); 
  }); 
 
  test("All methods for $locale moreCredits", () async {
    String moreCredits = localization.moreCredits();
    expect(true, moreCredits != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountTitle", () async {
    String moreDeleteAccountTitle = localization.moreDeleteAccountTitle();
    expect(true, moreDeleteAccountTitle != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountContent", () async {
    String moreDeleteAccountContent = localization.moreDeleteAccountContent();
    expect(true, moreDeleteAccountContent != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountReasonsDoNotLikeApp", () async {
    String moreDeleteAccountReasonsDoNotLikeApp = localization.moreDeleteAccountReasonsDoNotLikeApp();
    expect(true, moreDeleteAccountReasonsDoNotLikeApp != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountReasonsSlowApp", () async {
    String moreDeleteAccountReasonsSlowApp = localization.moreDeleteAccountReasonsSlowApp();
    expect(true, moreDeleteAccountReasonsSlowApp != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountReasonsNotInterested", () async {
    String moreDeleteAccountReasonsNotInterested = localization.moreDeleteAccountReasonsNotInterested();
    expect(true, moreDeleteAccountReasonsNotInterested != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountReasonsAppHasErrors", () async {
    String moreDeleteAccountReasonsAppHasErrors = localization.moreDeleteAccountReasonsAppHasErrors();
    expect(true, moreDeleteAccountReasonsAppHasErrors != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountReasonsOtherReason", () async {
    String moreDeleteAccountReasonsOtherReason = localization.moreDeleteAccountReasonsOtherReason();
    expect(true, moreDeleteAccountReasonsOtherReason != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountReasonsDeclinePointReason", () async {
    String moreDeleteAccountReasonsDeclinePointReason = localization.moreDeleteAccountReasonsDeclinePointReason();
    expect(true, moreDeleteAccountReasonsDeclinePointReason != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountConfirmDeleteAccount", () async {
    String moreDeleteAccountConfirmDeleteAccount = localization.moreDeleteAccountConfirmDeleteAccount();
    expect(true, moreDeleteAccountConfirmDeleteAccount != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountAtLeastOneReasonRequired", () async {
    String moreDeleteAccountAtLeastOneReasonRequired = localization.moreDeleteAccountAtLeastOneReasonRequired();
    expect(true, moreDeleteAccountAtLeastOneReasonRequired != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountYouHaveToConfirm", () async {
    String moreDeleteAccountYouHaveToConfirm = localization.moreDeleteAccountYouHaveToConfirm();
    expect(true, moreDeleteAccountYouHaveToConfirm != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountAfterSuccessfulRequest", () async {
    String moreDeleteAccountAfterSuccessfulRequest = localization.moreDeleteAccountAfterSuccessfulRequest();
    expect(true, moreDeleteAccountAfterSuccessfulRequest != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountAdditionalNotes", () async {
    String moreDeleteAccountAdditionalNotes = localization.moreDeleteAccountAdditionalNotes();
    expect(true, moreDeleteAccountAdditionalNotes != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountDialogTitle", () async {
    String moreDeleteAccountDialogTitle = localization.moreDeleteAccountDialogTitle();
    expect(true, moreDeleteAccountDialogTitle != ""); 
  }); 
 
  test("All methods for $locale moreDeleteAccountDialogContent", () async {
    String moreDeleteAccountDialogContent = localization.moreDeleteAccountDialogContent();
    expect(true, moreDeleteAccountDialogContent != ""); 
  }); 
 
  test("All methods for $locale dashboardTitle", () async {
    String dashboardTitle = localization.dashboardTitle();
    expect(true, dashboardTitle != ""); 
  }); 
 
  test("All methods for $locale dashboardNearestMeetingTitle", () async {
    String dashboardNearestMeetingTitle = localization.dashboardNearestMeetingTitle();
    expect(true, dashboardNearestMeetingTitle != ""); 
  }); 
 
  test("All methods for $locale dashboardNearestMeetingAgenda", () async {
    String dashboardNearestMeetingAgenda = localization.dashboardNearestMeetingAgenda();
    expect(true, dashboardNearestMeetingAgenda != ""); 
  }); 
 
  test("All methods for $locale dashboardNearestMeetingSupplementingAgenda", () async {
    String dashboardNearestMeetingSupplementingAgenda = localization.dashboardNearestMeetingSupplementingAgenda();
    expect(true, dashboardNearestMeetingSupplementingAgenda != ""); 
  }); 
 
  test("All methods for $locale dashboardNearestMeetingToBeSettled", () async {
    String dashboardNearestMeetingToBeSettled = localization.dashboardNearestMeetingToBeSettled();
    expect(true, dashboardNearestMeetingToBeSettled != ""); 
  }); 
 
  test("All methods for $locale dashboardNearestMeetingParliamentMeeting", () async {
    String dashboardNearestMeetingParliamentMeeting = localization.dashboardNearestMeetingParliamentMeeting();
    expect(true, dashboardNearestMeetingParliamentMeeting != ""); 
  }); 
 
  test("All methods for $locale dashboardNotificationsTitle", () async {
    String dashboardNotificationsTitle = localization.dashboardNotificationsTitle();
    expect(true, dashboardNotificationsTitle != ""); 
  }); 
 
  test("All methods for $locale dashboardNotificationsFiltersSpeeches", () async {
    String dashboardNotificationsFiltersSpeeches = localization.dashboardNotificationsFiltersSpeeches();
    expect(true, dashboardNotificationsFiltersSpeeches != ""); 
  }); 
 
  test("All methods for $locale dashboardNotificationsFiltersVotes", () async {
    String dashboardNotificationsFiltersVotes = localization.dashboardNotificationsFiltersVotes();
    expect(true, dashboardNotificationsFiltersVotes != ""); 
  }); 
 
  test("All methods for $locale dashboardNotificationsFiltersNotRead", () async {
    String dashboardNotificationsFiltersNotRead = localization.dashboardNotificationsFiltersNotRead();
    expect(true, dashboardNotificationsFiltersNotRead != ""); 
  }); 
 
  test("All methods for $locale dashboardNotificationsRemoveAllDialogTitle", () async {
    String dashboardNotificationsRemoveAllDialogTitle = localization.dashboardNotificationsRemoveAllDialogTitle();
    expect(true, dashboardNotificationsRemoveAllDialogTitle != ""); 
  }); 
 
  test("All methods for $locale dashboardNotificationsRemoveAllDialogContent", () async {
    String dashboardNotificationsRemoveAllDialogContent = localization.dashboardNotificationsRemoveAllDialogContent();
    expect(true, dashboardNotificationsRemoveAllDialogContent != ""); 
  }); 
 
  test("All methods for $locale dashboardNotificationsRemoveAllDialogRemoveNotRead", () async {
    String dashboardNotificationsRemoveAllDialogRemoveNotRead = localization.dashboardNotificationsRemoveAllDialogRemoveNotRead();
    expect(true, dashboardNotificationsRemoveAllDialogRemoveNotRead != ""); 
  }); 
 
  test("All methods for $locale dashboardNotificationsRemoveAllDialogActionsYes", () async {
    String dashboardNotificationsRemoveAllDialogActionsYes = localization.dashboardNotificationsRemoveAllDialogActionsYes();
    expect(true, dashboardNotificationsRemoveAllDialogActionsYes != ""); 
  }); 
 
  test("All methods for $locale dashboardNotificationsRemoveAllDialogActionsNo", () async {
    String dashboardNotificationsRemoveAllDialogActionsNo = localization.dashboardNotificationsRemoveAllDialogActionsNo();
    expect(true, dashboardNotificationsRemoveAllDialogActionsNo != ""); 
  }); 
 
  test("All methods for $locale dashboardTilesNearestMeetingTileMeetingIsToday", () async {
    String dashboardTilesNearestMeetingTileMeetingIsToday = localization.dashboardTilesNearestMeetingTileMeetingIsToday();
    expect(true, dashboardTilesNearestMeetingTileMeetingIsToday != ""); 
  }); 
 
  test("All methods for $locale dashboardTilesNearestMeetingTileMeetingWasYesterday", () async {
    String dashboardTilesNearestMeetingTileMeetingWasYesterday = localization.dashboardTilesNearestMeetingTileMeetingWasYesterday();
    expect(true, dashboardTilesNearestMeetingTileMeetingWasYesterday != ""); 
  }); 
 
  test("All methods for $locale dashboardTilesNearestMeetingTileMeetingIsTomorrow", () async {
    String dashboardTilesNearestMeetingTileMeetingIsTomorrow = localization.dashboardTilesNearestMeetingTileMeetingIsTomorrow();
    expect(true, dashboardTilesNearestMeetingTileMeetingIsTomorrow != ""); 
  }); 
 
  test("All methods for $locale dashboardTilesNearestMeetingTileMeetingInDays", () async {
    String dashboardTilesNearestMeetingTileMeetingInDays = localization.dashboardTilesNearestMeetingTileMeetingInDays();
    expect(true, dashboardTilesNearestMeetingTileMeetingInDays != ""); 
  }); 
 
  test("All methods for $locale dashboardTilesNearestMeetingTileDays", () async {
    String dashboardTilesNearestMeetingTileDays = localization.dashboardTilesNearestMeetingTileDays();
    expect(true, dashboardTilesNearestMeetingTileDays != ""); 
  }); 
 
  test("All methods for $locale settingsSettingsTitle", () async {
    String settingsSettingsTitle = localization.settingsSettingsTitle();
    expect(true, settingsSettingsTitle != ""); 
  }); 
 
  test("All methods for $locale settingsButtonLogout", () async {
    String settingsButtonLogout = localization.settingsButtonLogout();
    expect(true, settingsButtonLogout != ""); 
  }); 
 
  test("All methods for $locale settingsSwitchTechnicalData", () async {
    String settingsSwitchTechnicalData = localization.settingsSwitchTechnicalData();
    expect(true, settingsSwitchTechnicalData != ""); 
  }); 
 
  test("All methods for $locale settingsSwitchWakelockTimeline", () async {
    String settingsSwitchWakelockTimeline = localization.settingsSwitchWakelockTimeline();
    expect(true, settingsSwitchWakelockTimeline != ""); 
  }); 
 
  test("All methods for $locale settingsHallOfFameTitle", () async {
    String settingsHallOfFameTitle = localization.settingsHallOfFameTitle();
    expect(true, settingsHallOfFameTitle != ""); 
  }); 
 
  test("All methods for $locale filtersTitle", () async {
    String filtersTitle = localization.filtersTitle();
    expect(true, filtersTitle != ""); 
  }); 
 
  test("All methods for $locale filtersFiltersDateFrom", () async {
    String filtersFiltersDateFrom = localization.filtersFiltersDateFrom();
    expect(true, filtersFiltersDateFrom != ""); 
  }); 
 
  test("All methods for $locale filtersFiltersDateTo", () async {
    String filtersFiltersDateTo = localization.filtersFiltersDateTo();
    expect(true, filtersFiltersDateTo != ""); 
  }); 
 
  test("All methods for $locale filtersFiltersSearchPhrase", () async {
    String filtersFiltersSearchPhrase = localization.filtersFiltersSearchPhrase();
    expect(true, filtersFiltersSearchPhrase != ""); 
  }); 
 
  test("All methods for $locale filtersFiltersSubscribed", () async {
    String filtersFiltersSubscribed = localization.filtersFiltersSubscribed();
    expect(true, filtersFiltersSubscribed != ""); 
  }); 
 
  test("All methods for $locale sortTitle", () async {
    String sortTitle = localization.sortTitle();
    expect(true, sortTitle != ""); 
  }); 
 
  test("All methods for $locale sortAscending", () async {
    String sortAscending = localization.sortAscending();
    expect(true, sortAscending != ""); 
  }); 
 
  test("All methods for $locale sortDescending", () async {
    String sortDescending = localization.sortDescending();
    expect(true, sortDescending != ""); 
  }); 
 
  test("All methods for $locale guestExplanation", () async {
    String guestExplanation = localization.guestExplanation();
    expect(true, guestExplanation != ""); 
  }); 
 
  test("All methods for $locale guestGoToLogin", () async {
    String guestGoToLogin = localization.guestGoToLogin();
    expect(true, guestGoToLogin != ""); 
  }); 
 
  test("All methods for $locale guestLogAsGuest", () async {
    String guestLogAsGuest = localization.guestLogAsGuest();
    expect(true, guestLogAsGuest != ""); 
  }); 
 
}
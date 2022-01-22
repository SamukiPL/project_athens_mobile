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
    expect(true, universalBack != "" && universalBack != null); 
  }); 
 
  test("All methods for $locale universalNext", () async {
    String universalNext = localization.universalNext();
    expect(true, universalNext != "" && universalNext != null); 
  }); 
 
  test("All methods for $locale universalCancel", () async {
    String universalCancel = localization.universalCancel();
    expect(true, universalCancel != "" && universalCancel != null); 
  }); 
 
  test("All methods for $locale universalSkip", () async {
    String universalSkip = localization.universalSkip();
    expect(true, universalSkip != "" && universalSkip != null); 
  }); 
 
  test("All methods for $locale universalChoose", () async {
    String universalChoose = localization.universalChoose();
    expect(true, universalChoose != "" && universalChoose != null); 
  }); 
 
  test("All methods for $locale universalOk", () async {
    String universalOk = localization.universalOk();
    expect(true, universalOk != "" && universalOk != null); 
  }); 
 
  test("All methods for $locale universalRetry", () async {
    String universalRetry = localization.universalRetry();
    expect(true, universalRetry != "" && universalRetry != null); 
  }); 
 
  test("All methods for $locale universalClose", () async {
    String universalClose = localization.universalClose();
    expect(true, universalClose != "" && universalClose != null); 
  }); 
 
  test("All methods for $locale universalNoDataDefaultText", () async {
    String universalNoDataDefaultText = localization.universalNoDataDefaultText();
    expect(true, universalNoDataDefaultText != "" && universalNoDataDefaultText != null); 
  }); 
 
  test("All methods for $locale universalNoDataNoInformation", () async {
    String universalNoDataNoInformation = localization.universalNoDataNoInformation();
    expect(true, universalNoDataNoInformation != "" && universalNoDataNoInformation != null); 
  }); 
 
  test("All methods for $locale universalInformation", () async {
    String universalInformation = localization.universalInformation();
    expect(true, universalInformation != "" && universalInformation != null); 
  }); 
 
  test("All methods for $locale universalExperimentalFeatureContent", () async {
    String universalExperimentalFeatureContent = localization.universalExperimentalFeatureContent();
    expect(true, universalExperimentalFeatureContent != "" && universalExperimentalFeatureContent != null); 
  }); 
 
  test("All methods for $locale universalExperimentalFeatureTitle", () async {
    String universalExperimentalFeatureTitle = localization.universalExperimentalFeatureTitle();
    expect(true, universalExperimentalFeatureTitle != "" && universalExperimentalFeatureTitle != null); 
  }); 
 
  test("All methods for $locale universalErrorNetwork", () async {
    String universalErrorNetwork = localization.universalErrorNetwork();
    expect(true, universalErrorNetwork != "" && universalErrorNetwork != null); 
  }); 
 
  test("All methods for $locale universalErrorServer", () async {
    String universalErrorServer = localization.universalErrorServer();
    expect(true, universalErrorServer != "" && universalErrorServer != null); 
  }); 
 
  test("All methods for $locale universalErrorUnknown", () async {
    String universalErrorUnknown = localization.universalErrorUnknown();
    expect(true, universalErrorUnknown != "" && universalErrorUnknown != null); 
  }); 
 
  test("All methods for $locale universalSource", () async {
    String universalSource = localization.universalSource();
    expect(true, universalSource != "" && universalSource != null); 
  }); 
 
  test("All methods for $locale universalCreatedAt", () async {
    String universalCreatedAt = localization.universalCreatedAt();
    expect(true, universalCreatedAt != "" && universalCreatedAt != null); 
  }); 
 
  test("All methods for $locale universalUpdatedAt", () async {
    String universalUpdatedAt = localization.universalUpdatedAt();
    expect(true, universalUpdatedAt != "" && universalUpdatedAt != null); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogTitle", () async {
    String universalUpdateCupertinoDialogTitle = localization.universalUpdateCupertinoDialogTitle();
    expect(true, universalUpdateCupertinoDialogTitle != "" && universalUpdateCupertinoDialogTitle != null); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogButtonIgnore", () async {
    String universalUpdateCupertinoDialogButtonIgnore = localization.universalUpdateCupertinoDialogButtonIgnore();
    expect(true, universalUpdateCupertinoDialogButtonIgnore != "" && universalUpdateCupertinoDialogButtonIgnore != null); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogButtonLater", () async {
    String universalUpdateCupertinoDialogButtonLater = localization.universalUpdateCupertinoDialogButtonLater();
    expect(true, universalUpdateCupertinoDialogButtonLater != "" && universalUpdateCupertinoDialogButtonLater != null); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogButtonUpdateNow", () async {
    String universalUpdateCupertinoDialogButtonUpdateNow = localization.universalUpdateCupertinoDialogButtonUpdateNow();
    expect(true, universalUpdateCupertinoDialogButtonUpdateNow != "" && universalUpdateCupertinoDialogButtonUpdateNow != null); 
  }); 
 
  test("All methods for $locale universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow", () async {
    String universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow = localization.universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow();
    expect(true, universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow != "" && universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow != null); 
  }); 
 
  test("All methods for $locale mainMenuSession", () async {
    String mainMenuSession = localization.mainMenuSession();
    expect(true, mainMenuSession != "" && mainMenuSession != null); 
  }); 
 
  test("All methods for $locale mainMenuMusic", () async {
    String mainMenuMusic = localization.mainMenuMusic();
    expect(true, mainMenuMusic != "" && mainMenuMusic != null); 
  }); 
 
  test("All methods for $locale mainMenuMaterials", () async {
    String mainMenuMaterials = localization.mainMenuMaterials();
    expect(true, mainMenuMaterials != "" && mainMenuMaterials != null); 
  }); 
 
  test("All methods for $locale mainMenuCharactersCards", () async {
    String mainMenuCharactersCards = localization.mainMenuCharactersCards();
    expect(true, mainMenuCharactersCards != "" && mainMenuCharactersCards != null); 
  }); 
 
  test("All methods for $locale mainMenuActiveSessions", () async {
    String mainMenuActiveSessions = localization.mainMenuActiveSessions();
    expect(true, mainMenuActiveSessions != "" && mainMenuActiveSessions != null); 
  }); 
 
  test("All methods for $locale mainMenuSurveys", () async {
    String mainMenuSurveys = localization.mainMenuSurveys();
    expect(true, mainMenuSurveys != "" && mainMenuSurveys != null); 
  }); 
 
  test("All methods for $locale mainMenuSystems", () async {
    String mainMenuSystems = localization.mainMenuSystems();
    expect(true, mainMenuSystems != "" && mainMenuSystems != null); 
  }); 
 
  test("All methods for $locale loginButtonsLogin", () async {
    String loginButtonsLogin = localization.loginButtonsLogin();
    expect(true, loginButtonsLogin != "" && loginButtonsLogin != null); 
  }); 
 
  test("All methods for $locale loginButtonsRegister", () async {
    String loginButtonsRegister = localization.loginButtonsRegister();
    expect(true, loginButtonsRegister != "" && loginButtonsRegister != null); 
  }); 
 
  test("All methods for $locale loginButtonsForgot", () async {
    String loginButtonsForgot = localization.loginButtonsForgot();
    expect(true, loginButtonsForgot != "" && loginButtonsForgot != null); 
  }); 
 
  test("All methods for $locale loginButtonsSignUp", () async {
    String loginButtonsSignUp = localization.loginButtonsSignUp();
    expect(true, loginButtonsSignUp != "" && loginButtonsSignUp != null); 
  }); 
 
  test("All methods for $locale loginButtonsResetPassword", () async {
    String loginButtonsResetPassword = localization.loginButtonsResetPassword();
    expect(true, loginButtonsResetPassword != "" && loginButtonsResetPassword != null); 
  }); 
 
  test("All methods for $locale loginHintsEmail", () async {
    String loginHintsEmail = localization.loginHintsEmail();
    expect(true, loginHintsEmail != "" && loginHintsEmail != null); 
  }); 
 
  test("All methods for $locale loginHintsRepeatEmail", () async {
    String loginHintsRepeatEmail = localization.loginHintsRepeatEmail();
    expect(true, loginHintsRepeatEmail != "" && loginHintsRepeatEmail != null); 
  }); 
 
  test("All methods for $locale loginHintsLogin", () async {
    String loginHintsLogin = localization.loginHintsLogin();
    expect(true, loginHintsLogin != "" && loginHintsLogin != null); 
  }); 
 
  test("All methods for $locale loginHintsLoginOrEmail", () async {
    String loginHintsLoginOrEmail = localization.loginHintsLoginOrEmail();
    expect(true, loginHintsLoginOrEmail != "" && loginHintsLoginOrEmail != null); 
  }); 
 
  test("All methods for $locale loginHintsName", () async {
    String loginHintsName = localization.loginHintsName();
    expect(true, loginHintsName != "" && loginHintsName != null); 
  }); 
 
  test("All methods for $locale loginHintsPassword", () async {
    String loginHintsPassword = localization.loginHintsPassword();
    expect(true, loginHintsPassword != "" && loginHintsPassword != null); 
  }); 
 
  test("All methods for $locale loginHintsRepeatPassword", () async {
    String loginHintsRepeatPassword = localization.loginHintsRepeatPassword();
    expect(true, loginHintsRepeatPassword != "" && loginHintsRepeatPassword != null); 
  }); 
 
  test("All methods for $locale loginHintsFirstName", () async {
    String loginHintsFirstName = localization.loginHintsFirstName();
    expect(true, loginHintsFirstName != "" && loginHintsFirstName != null); 
  }); 
 
  test("All methods for $locale loginHintsLastName", () async {
    String loginHintsLastName = localization.loginHintsLastName();
    expect(true, loginHintsLastName != "" && loginHintsLastName != null); 
  }); 
 
  test("All methods for $locale loginOtherForgotRationale", () async {
    String loginOtherForgotRationale = localization.loginOtherForgotRationale();
    expect(true, loginOtherForgotRationale != "" && loginOtherForgotRationale != null); 
  }); 
 
  test("All methods for $locale loginOtherFacebook", () async {
    String loginOtherFacebook = localization.loginOtherFacebook();
    expect(true, loginOtherFacebook != "" && loginOtherFacebook != null); 
  }); 
 
  test("All methods for $locale loginOtherTwitter", () async {
    String loginOtherTwitter = localization.loginOtherTwitter();
    expect(true, loginOtherTwitter != "" && loginOtherTwitter != null); 
  }); 
 
  test("All methods for $locale loginOtherGoogle", () async {
    String loginOtherGoogle = localization.loginOtherGoogle();
    expect(true, loginOtherGoogle != "" && loginOtherGoogle != null); 
  }); 
 
  test("All methods for $locale loginOtherNotAMember", () async {
    String loginOtherNotAMember = localization.loginOtherNotAMember();
    expect(true, loginOtherNotAMember != "" && loginOtherNotAMember != null); 
  }); 
 
  test("All methods for $locale loginOtherConnectWith", () async {
    String loginOtherConnectWith = localization.loginOtherConnectWith();
    expect(true, loginOtherConnectWith != "" && loginOtherConnectWith != null); 
  }); 
 
  test("All methods for $locale loginValidateFieldCannotBeEmpty", () async {
    String loginValidateFieldCannotBeEmpty = localization.loginValidateFieldCannotBeEmpty();
    expect(true, loginValidateFieldCannotBeEmpty != "" && loginValidateFieldCannotBeEmpty != null); 
  }); 
 
  test("All methods for $locale loginValidateIncorrectEmail", () async {
    String loginValidateIncorrectEmail = localization.loginValidateIncorrectEmail();
    expect(true, loginValidateIncorrectEmail != "" && loginValidateIncorrectEmail != null); 
  }); 
 
  test("All methods for $locale loginValidateLoginIsTaken", () async {
    String loginValidateLoginIsTaken = localization.loginValidateLoginIsTaken();
    expect(true, loginValidateLoginIsTaken != "" && loginValidateLoginIsTaken != null); 
  }); 
 
  test("All methods for $locale loginValidateLoginIsInvalid", () async {
    String loginValidateLoginIsInvalid = localization.loginValidateLoginIsInvalid();
    expect(true, loginValidateLoginIsInvalid != "" && loginValidateLoginIsInvalid != null); 
  }); 
 
  test("All methods for $locale loginValidateEmailIsTaken", () async {
    String loginValidateEmailIsTaken = localization.loginValidateEmailIsTaken();
    expect(true, loginValidateEmailIsTaken != "" && loginValidateEmailIsTaken != null); 
  }); 
 
  test("All methods for $locale loginValidateEmailsDontMatch", () async {
    String loginValidateEmailsDontMatch = localization.loginValidateEmailsDontMatch();
    expect(true, loginValidateEmailsDontMatch != "" && loginValidateEmailsDontMatch != null); 
  }); 
 
  test("All methods for $locale loginValidatePasswordsDontMatch", () async {
    String loginValidatePasswordsDontMatch = localization.loginValidatePasswordsDontMatch();
    expect(true, loginValidatePasswordsDontMatch != "" && loginValidatePasswordsDontMatch != null); 
  }); 
 
  test("All methods for $locale loginValidateWrongData", () async {
    String loginValidateWrongData = localization.loginValidateWrongData();
    expect(true, loginValidateWrongData != "" && loginValidateWrongData != null); 
  }); 
 
  test("All methods for $locale loginErrorPasswordOrLoginDoesNotMatch", () async {
    String loginErrorPasswordOrLoginDoesNotMatch = localization.loginErrorPasswordOrLoginDoesNotMatch();
    expect(true, loginErrorPasswordOrLoginDoesNotMatch != "" && loginErrorPasswordOrLoginDoesNotMatch != null); 
  }); 
 
  test("All methods for $locale timelineVote", () async {
    String timelineVote = localization.timelineVote();
    expect(true, timelineVote != "" && timelineVote != null); 
  }); 
 
  test("All methods for $locale timelineVoteNoAgenda", () async {
    String timelineVoteNoAgenda = localization.timelineVoteNoAgenda();
    expect(true, timelineVoteNoAgenda != "" && timelineVoteNoAgenda != null); 
  }); 
 
  test("All methods for $locale timelineTimelineNavTitle", () async {
    String timelineTimelineNavTitle = localization.timelineTimelineNavTitle();
    expect(true, timelineTimelineNavTitle != "" && timelineTimelineNavTitle != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesResolutionProject", () async {
    String timelineVotingTypesResolutionProject = localization.timelineVotingTypesResolutionProject();
    expect(true, timelineVotingTypesResolutionProject != "" && timelineVotingTypesResolutionProject != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesLawProject", () async {
    String timelineVotingTypesLawProject = localization.timelineVotingTypesLawProject();
    expect(true, timelineVotingTypesLawProject != "" && timelineVotingTypesLawProject != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesBreak", () async {
    String timelineVotingTypesBreak = localization.timelineVotingTypesBreak();
    expect(true, timelineVotingTypesBreak != "" && timelineVotingTypesBreak != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesQuorum", () async {
    String timelineVotingTypesQuorum = localization.timelineVotingTypesQuorum();
    expect(true, timelineVotingTypesQuorum != "" && timelineVotingTypesQuorum != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesReport", () async {
    String timelineVotingTypesReport = localization.timelineVotingTypesReport();
    expect(true, timelineVotingTypesReport != "" && timelineVotingTypesReport != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesVoteOfNoConfidence", () async {
    String timelineVotingTypesVoteOfNoConfidence = localization.timelineVotingTypesVoteOfNoConfidence();
    expect(true, timelineVotingTypesVoteOfNoConfidence != "" && timelineVotingTypesVoteOfNoConfidence != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesCompletionOfAgenda", () async {
    String timelineVotingTypesCompletionOfAgenda = localization.timelineVotingTypesCompletionOfAgenda();
    expect(true, timelineVotingTypesCompletionOfAgenda != "" && timelineVotingTypesCompletionOfAgenda != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesShorteningDeadline", () async {
    String timelineVotingTypesShorteningDeadline = localization.timelineVotingTypesShorteningDeadline();
    expect(true, timelineVotingTypesShorteningDeadline != "" && timelineVotingTypesShorteningDeadline != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesChangeCommissionMembers", () async {
    String timelineVotingTypesChangeCommissionMembers = localization.timelineVotingTypesChangeCommissionMembers();
    expect(true, timelineVotingTypesChangeCommissionMembers != "" && timelineVotingTypesChangeCommissionMembers != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesVoteForProposal", () async {
    String timelineVotingTypesVoteForProposal = localization.timelineVotingTypesVoteForProposal();
    expect(true, timelineVotingTypesVoteForProposal != "" && timelineVotingTypesVoteForProposal != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesPersonVote", () async {
    String timelineVotingTypesPersonVote = localization.timelineVotingTypesPersonVote();
    expect(true, timelineVotingTypesPersonVote != "" && timelineVotingTypesPersonVote != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesVoteForPostponementGathering", () async {
    String timelineVotingTypesVoteForPostponementGathering = localization.timelineVotingTypesVoteForPostponementGathering();
    expect(true, timelineVotingTypesVoteForPostponementGathering != "" && timelineVotingTypesVoteForPostponementGathering != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesMarshal", () async {
    String timelineVotingTypesMarshal = localization.timelineVotingTypesMarshal();
    expect(true, timelineVotingTypesMarshal != "" && timelineVotingTypesMarshal != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesViceMarshal", () async {
    String timelineVotingTypesViceMarshal = localization.timelineVotingTypesViceMarshal();
    expect(true, timelineVotingTypesViceMarshal != "" && timelineVotingTypesViceMarshal != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesChooseComissionMembers", () async {
    String timelineVotingTypesChooseComissionMembers = localization.timelineVotingTypesChooseComissionMembers();
    expect(true, timelineVotingTypesChooseComissionMembers != "" && timelineVotingTypesChooseComissionMembers != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesSelectionOfParliamentSecretaries", () async {
    String timelineVotingTypesSelectionOfParliamentSecretaries = localization.timelineVotingTypesSelectionOfParliamentSecretaries();
    expect(true, timelineVotingTypesSelectionOfParliamentSecretaries != "" && timelineVotingTypesSelectionOfParliamentSecretaries != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesVoteOfConfidence", () async {
    String timelineVotingTypesVoteOfConfidence = localization.timelineVotingTypesVoteOfConfidence();
    expect(true, timelineVotingTypesVoteOfConfidence != "" && timelineVotingTypesVoteOfConfidence != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesSelectionOfStateTribunal", () async {
    String timelineVotingTypesSelectionOfStateTribunal = localization.timelineVotingTypesSelectionOfStateTribunal();
    expect(true, timelineVotingTypesSelectionOfStateTribunal != "" && timelineVotingTypesSelectionOfStateTribunal != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesSelectionOfConstitutionalCourt", () async {
    String timelineVotingTypesSelectionOfConstitutionalCourt = localization.timelineVotingTypesSelectionOfConstitutionalCourt();
    expect(true, timelineVotingTypesSelectionOfConstitutionalCourt != "" && timelineVotingTypesSelectionOfConstitutionalCourt != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesSelectionOfNationalCouncilJudiciary", () async {
    String timelineVotingTypesSelectionOfNationalCouncilJudiciary = localization.timelineVotingTypesSelectionOfNationalCouncilJudiciary();
    expect(true, timelineVotingTypesSelectionOfNationalCouncilJudiciary != "" && timelineVotingTypesSelectionOfNationalCouncilJudiciary != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesRepealOfRegulation", () async {
    String timelineVotingTypesRepealOfRegulation = localization.timelineVotingTypesRepealOfRegulation();
    expect(true, timelineVotingTypesRepealOfRegulation != "" && timelineVotingTypesRepealOfRegulation != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesResolutionOfPointOfDispute", () async {
    String timelineVotingTypesResolutionOfPointOfDispute = localization.timelineVotingTypesResolutionOfPointOfDispute();
    expect(true, timelineVotingTypesResolutionOfPointOfDispute != "" && timelineVotingTypesResolutionOfPointOfDispute != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesRequestOfReassumingVote", () async {
    String timelineVotingTypesRequestOfReassumingVote = localization.timelineVotingTypesRequestOfReassumingVote();
    expect(true, timelineVotingTypesRequestOfReassumingVote != "" && timelineVotingTypesRequestOfReassumingVote != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesRequestOfClosingMeeting", () async {
    String timelineVotingTypesRequestOfClosingMeeting = localization.timelineVotingTypesRequestOfClosingMeeting();
    expect(true, timelineVotingTypesRequestOfClosingMeeting != "" && timelineVotingTypesRequestOfClosingMeeting != null); 
  }); 
 
  test("All methods for $locale timelineVotingTypesUnknown", () async {
    String timelineVotingTypesUnknown = localization.timelineVotingTypesUnknown();
    expect(true, timelineVotingTypesUnknown != "" && timelineVotingTypesUnknown != null); 
  }); 
 
  test("All methods for $locale timelineNounCloudNoNouns", () async {
    String timelineNounCloudNoNouns = localization.timelineNounCloudNoNouns();
    expect(true, timelineNounCloudNoNouns != "" && timelineNounCloudNoNouns != null); 
  }); 
 
  test("All methods for $locale timelineNoEvents", () async {
    String timelineNoEvents = localization.timelineNoEvents();
    expect(true, timelineNoEvents != "" && timelineNoEvents != null); 
  }); 
 
  test("All methods for $locale deputiesDeputiesListTitle", () async {
    String deputiesDeputiesListTitle = localization.deputiesDeputiesListTitle();
    expect(true, deputiesDeputiesListTitle != "" && deputiesDeputiesListTitle != null); 
  }); 
 
  test("All methods for $locale deputiesInformation", () async {
    String deputiesInformation = localization.deputiesInformation();
    expect(true, deputiesInformation != "" && deputiesInformation != null); 
  }); 
 
  test("All methods for $locale deputiesSpeeches", () async {
    String deputiesSpeeches = localization.deputiesSpeeches();
    expect(true, deputiesSpeeches != "" && deputiesSpeeches != null); 
  }); 
 
  test("All methods for $locale deputiesVotings", () async {
    String deputiesVotings = localization.deputiesVotings();
    expect(true, deputiesVotings != "" && deputiesVotings != null); 
  }); 
 
  test("All methods for $locale deputiesBirthDate", () async {
    String deputiesBirthDate = localization.deputiesBirthDate();
    expect(true, deputiesBirthDate != "" && deputiesBirthDate != null); 
  }); 
 
  test("All methods for $locale deputiesEducation", () async {
    String deputiesEducation = localization.deputiesEducation();
    expect(true, deputiesEducation != "" && deputiesEducation != null); 
  }); 
 
  test("All methods for $locale deputiesProfession", () async {
    String deputiesProfession = localization.deputiesProfession();
    expect(true, deputiesProfession != "" && deputiesProfession != null); 
  }); 
 
  test("All methods for $locale deputiesFinishedSchools", () async {
    String deputiesFinishedSchools = localization.deputiesFinishedSchools();
    expect(true, deputiesFinishedSchools != "" && deputiesFinishedSchools != null); 
  }); 
 
  test("All methods for $locale deputiesParliamentExperience", () async {
    String deputiesParliamentExperience = localization.deputiesParliamentExperience();
    expect(true, deputiesParliamentExperience != "" && deputiesParliamentExperience != null); 
  }); 
 
  test("All methods for $locale deputiesNoHighestAccuracy", () async {
    String deputiesNoHighestAccuracy = localization.deputiesNoHighestAccuracy();
    expect(true, deputiesNoHighestAccuracy != "" && deputiesNoHighestAccuracy != null); 
  }); 
 
  test("All methods for $locale deputiesSpeechCounter", () async {
    String deputiesSpeechCounter = localization.deputiesSpeechCounter();
    expect(true, deputiesSpeechCounter != "" && deputiesSpeechCounter != null); 
  }); 
 
  test("All methods for $locale deputiesVoteAbsency", () async {
    String deputiesVoteAbsency = localization.deputiesVoteAbsency();
    expect(true, deputiesVoteAbsency != "" && deputiesVoteAbsency != null); 
  }); 
 
  test("All methods for $locale deputiesMostAccuracy", () async {
    String deputiesMostAccuracy = localization.deputiesMostAccuracy();
    expect(true, deputiesMostAccuracy != "" && deputiesMostAccuracy != null); 
  }); 
 
  test("All methods for $locale deputiesVoteAccuracy", () async {
    String deputiesVoteAccuracy = localization.deputiesVoteAccuracy();
    expect(true, deputiesVoteAccuracy != "" && deputiesVoteAccuracy != null); 
  }); 
 
  test("All methods for $locale deputiesAlignedWithParty", () async {
    String deputiesAlignedWithParty = localization.deputiesAlignedWithParty();
    expect(true, deputiesAlignedWithParty != "" && deputiesAlignedWithParty != null); 
  }); 
 
  test("All methods for $locale deputiesNotAlignedWithParty", () async {
    String deputiesNotAlignedWithParty = localization.deputiesNotAlignedWithParty();
    expect(true, deputiesNotAlignedWithParty != "" && deputiesNotAlignedWithParty != null); 
  }); 
 
  test("All methods for $locale deputiesBasicInfo", () async {
    String deputiesBasicInfo = localization.deputiesBasicInfo();
    expect(true, deputiesBasicInfo != "" && deputiesBasicInfo != null); 
  }); 
 
  test("All methods for $locale deputiesExperience", () async {
    String deputiesExperience = localization.deputiesExperience();
    expect(true, deputiesExperience != "" && deputiesExperience != null); 
  }); 
 
  test("All methods for $locale deputiesStatistics", () async {
    String deputiesStatistics = localization.deputiesStatistics();
    expect(true, deputiesStatistics != "" && deputiesStatistics != null); 
  }); 
 
  test("All methods for $locale deputiesStatisticsInfo", () async {
    String deputiesStatisticsInfo = localization.deputiesStatisticsInfo();
    expect(true, deputiesStatisticsInfo != "" && deputiesStatisticsInfo != null); 
  }); 
 
  test("All methods for $locale deputiesWordCloud", () async {
    String deputiesWordCloud = localization.deputiesWordCloud();
    expect(true, deputiesWordCloud != "" && deputiesWordCloud != null); 
  }); 
 
  test("All methods for $locale deputiesWordCloudInfo", () async {
    String deputiesWordCloudInfo = localization.deputiesWordCloudInfo();
    expect(true, deputiesWordCloudInfo != "" && deputiesWordCloudInfo != null); 
  }); 
 
  test("All methods for $locale deputiesSubscribe", () async {
    String deputiesSubscribe = localization.deputiesSubscribe();
    expect(true, deputiesSubscribe != "" && deputiesSubscribe != null); 
  }); 
 
  test("All methods for $locale deputiesNotSubscribingDeputy", () async {
    String deputiesNotSubscribingDeputy = localization.deputiesNotSubscribingDeputy();
    expect(true, deputiesNotSubscribingDeputy != "" && deputiesNotSubscribingDeputy != null); 
  }); 
 
  test("All methods for $locale deputiesSubscribingDeputy", () async {
    String deputiesSubscribingDeputy = localization.deputiesSubscribingDeputy();
    expect(true, deputiesSubscribingDeputy != "" && deputiesSubscribingDeputy != null); 
  }); 
 
  test("All methods for $locale speechesSpeechesListTitle", () async {
    String speechesSpeechesListTitle = localization.speechesSpeechesListTitle();
    expect(true, speechesSpeechesListTitle != "" && speechesSpeechesListTitle != null); 
  }); 
 
  test("All methods for $locale speechesSpeechDetailsTitle", () async {
    String speechesSpeechDetailsTitle = localization.speechesSpeechDetailsTitle();
    expect(true, speechesSpeechDetailsTitle != "" && speechesSpeechDetailsTitle != null); 
  }); 
 
  test("All methods for $locale speechesNoData", () async {
    String speechesNoData = localization.speechesNoData();
    expect(true, speechesNoData != "" && speechesNoData != null); 
  }); 
 
  test("All methods for $locale speechesPreviousSpeech", () async {
    String speechesPreviousSpeech = localization.speechesPreviousSpeech();
    expect(true, speechesPreviousSpeech != "" && speechesPreviousSpeech != null); 
  }); 
 
  test("All methods for $locale speechesNextSpeech", () async {
    String speechesNextSpeech = localization.speechesNextSpeech();
    expect(true, speechesNextSpeech != "" && speechesNextSpeech != null); 
  }); 
 
  test("All methods for $locale speechesPlayNow", () async {
    String speechesPlayNow = localization.speechesPlayNow();
    expect(true, speechesPlayNow != "" && speechesPlayNow != null); 
  }); 
 
  test("All methods for $locale votingsVotingListTitle", () async {
    String votingsVotingListTitle = localization.votingsVotingListTitle();
    expect(true, votingsVotingListTitle != "" && votingsVotingListTitle != null); 
  }); 
 
  test("All methods for $locale votingsVoteTypesTotalDeputiesPlural", () async {
    String votingsVoteTypesTotalDeputiesPlural = localization.votingsVoteTypesTotalDeputiesPlural();
    expect(true, votingsVoteTypesTotalDeputiesPlural != "" && votingsVoteTypesTotalDeputiesPlural != null); 
  }); 
 
  test("All methods for $locale votingsVoteTypesActualVotedDeputiesPlural", () async {
    String votingsVoteTypesActualVotedDeputiesPlural = localization.votingsVoteTypesActualVotedDeputiesPlural();
    expect(true, votingsVoteTypesActualVotedDeputiesPlural != "" && votingsVoteTypesActualVotedDeputiesPlural != null); 
  }); 
 
  test("All methods for $locale votingsVoteTypesInFavorSingle", () async {
    String votingsVoteTypesInFavorSingle = localization.votingsVoteTypesInFavorSingle();
    expect(true, votingsVoteTypesInFavorSingle != "" && votingsVoteTypesInFavorSingle != null); 
  }); 
 
  test("All methods for $locale votingsVoteTypesInFavor", () async {
    String votingsVoteTypesInFavor = localization.votingsVoteTypesInFavor();
    expect(true, votingsVoteTypesInFavor != "" && votingsVoteTypesInFavor != null); 
  }); 
 
  test("All methods for $locale votingsVoteTypesAgainstSingle", () async {
    String votingsVoteTypesAgainstSingle = localization.votingsVoteTypesAgainstSingle();
    expect(true, votingsVoteTypesAgainstSingle != "" && votingsVoteTypesAgainstSingle != null); 
  }); 
 
  test("All methods for $locale votingsVoteTypesAgainst", () async {
    String votingsVoteTypesAgainst = localization.votingsVoteTypesAgainst();
    expect(true, votingsVoteTypesAgainst != "" && votingsVoteTypesAgainst != null); 
  }); 
 
  test("All methods for $locale votingsVoteTypesHoldPlural", () async {
    String votingsVoteTypesHoldPlural = localization.votingsVoteTypesHoldPlural();
    expect(true, votingsVoteTypesHoldPlural != "" && votingsVoteTypesHoldPlural != null); 
  }); 
 
  test("All methods for $locale votingsVoteTypesAbsentPlural", () async {
    String votingsVoteTypesAbsentPlural = localization.votingsVoteTypesAbsentPlural();
    expect(true, votingsVoteTypesAbsentPlural != "" && votingsVoteTypesAbsentPlural != null); 
  }); 
 
  test("All methods for $locale votingsVoteTypesHoldSingle", () async {
    String votingsVoteTypesHoldSingle = localization.votingsVoteTypesHoldSingle();
    expect(true, votingsVoteTypesHoldSingle != "" && votingsVoteTypesHoldSingle != null); 
  }); 
 
  test("All methods for $locale votingsVoteTypesAbsentSingle", () async {
    String votingsVoteTypesAbsentSingle = localization.votingsVoteTypesAbsentSingle();
    expect(true, votingsVoteTypesAbsentSingle != "" && votingsVoteTypesAbsentSingle != null); 
  }); 
 
  test("All methods for $locale votingsFiltersAccepted", () async {
    String votingsFiltersAccepted = localization.votingsFiltersAccepted();
    expect(true, votingsFiltersAccepted != "" && votingsFiltersAccepted != null); 
  }); 
 
  test("All methods for $locale votingsFiltersRejected", () async {
    String votingsFiltersRejected = localization.votingsFiltersRejected();
    expect(true, votingsFiltersRejected != "" && votingsFiltersRejected != null); 
  }); 
 
  test("All methods for $locale votingsSubscribedDeputiesVotes", () async {
    String votingsSubscribedDeputiesVotes = localization.votingsSubscribedDeputiesVotes();
    expect(true, votingsSubscribedDeputiesVotes != "" && votingsSubscribedDeputiesVotes != null); 
  }); 
 
  test("All methods for $locale votingsVotesNeededToPass", () async {
    String votingsVotesNeededToPass = localization.votingsVotesNeededToPass();
    expect(true, votingsVotesNeededToPass != "" && votingsVotesNeededToPass != null); 
  }); 
 
  test("All methods for $locale votingsNoData", () async {
    String votingsNoData = localization.votingsNoData();
    expect(true, votingsNoData != "" && votingsNoData != null); 
  }); 
 
  test("All methods for $locale moreTitle", () async {
    String moreTitle = localization.moreTitle();
    expect(true, moreTitle != "" && moreTitle != null); 
  }); 
 
  test("All methods for $locale moreUser", () async {
    String moreUser = localization.moreUser();
    expect(true, moreUser != "" && moreUser != null); 
  }); 
 
  test("All methods for $locale moreGoToSettings", () async {
    String moreGoToSettings = localization.moreGoToSettings();
    expect(true, moreGoToSettings != "" && moreGoToSettings != null); 
  }); 
 
  test("All methods for $locale moreLikeApplication", () async {
    String moreLikeApplication = localization.moreLikeApplication();
    expect(true, moreLikeApplication != "" && moreLikeApplication != null); 
  }); 
 
  test("All methods for $locale moreSupportUs", () async {
    String moreSupportUs = localization.moreSupportUs();
    expect(true, moreSupportUs != "" && moreSupportUs != null); 
  }); 
 
  test("All methods for $locale moreCheckForUpdates", () async {
    String moreCheckForUpdates = localization.moreCheckForUpdates();
    expect(true, moreCheckForUpdates != "" && moreCheckForUpdates != null); 
  }); 
 
  test("All methods for $locale moreAppVersion", () async {
    String moreAppVersion = localization.moreAppVersion();
    expect(true, moreAppVersion != "" && moreAppVersion != null); 
  }); 
 
  test("All methods for $locale moreCredits", () async {
    String moreCredits = localization.moreCredits();
    expect(true, moreCredits != "" && moreCredits != null); 
  }); 
 
  test("All methods for $locale dashboardTitle", () async {
    String dashboardTitle = localization.dashboardTitle();
    expect(true, dashboardTitle != "" && dashboardTitle != null); 
  }); 
 
  test("All methods for $locale dashboardNearestMeetingTitle", () async {
    String dashboardNearestMeetingTitle = localization.dashboardNearestMeetingTitle();
    expect(true, dashboardNearestMeetingTitle != "" && dashboardNearestMeetingTitle != null); 
  }); 
 
  test("All methods for $locale dashboardNearestMeetingAgenda", () async {
    String dashboardNearestMeetingAgenda = localization.dashboardNearestMeetingAgenda();
    expect(true, dashboardNearestMeetingAgenda != "" && dashboardNearestMeetingAgenda != null); 
  }); 
 
  test("All methods for $locale dashboardNearestMeetingSupplementingAgenda", () async {
    String dashboardNearestMeetingSupplementingAgenda = localization.dashboardNearestMeetingSupplementingAgenda();
    expect(true, dashboardNearestMeetingSupplementingAgenda != "" && dashboardNearestMeetingSupplementingAgenda != null); 
  }); 
 
  test("All methods for $locale dashboardNearestMeetingToBeSettled", () async {
    String dashboardNearestMeetingToBeSettled = localization.dashboardNearestMeetingToBeSettled();
    expect(true, dashboardNearestMeetingToBeSettled != "" && dashboardNearestMeetingToBeSettled != null); 
  }); 
 
  test("All methods for $locale dashboardNearestMeetingParliamentMeeting", () async {
    String dashboardNearestMeetingParliamentMeeting = localization.dashboardNearestMeetingParliamentMeeting();
    expect(true, dashboardNearestMeetingParliamentMeeting != "" && dashboardNearestMeetingParliamentMeeting != null); 
  }); 
 
  test("All methods for $locale dashboardNotificationsTitle", () async {
    String dashboardNotificationsTitle = localization.dashboardNotificationsTitle();
    expect(true, dashboardNotificationsTitle != "" && dashboardNotificationsTitle != null); 
  }); 
 
  test("All methods for $locale dashboardNotificationsFiltersSpeeches", () async {
    String dashboardNotificationsFiltersSpeeches = localization.dashboardNotificationsFiltersSpeeches();
    expect(true, dashboardNotificationsFiltersSpeeches != "" && dashboardNotificationsFiltersSpeeches != null); 
  }); 
 
  test("All methods for $locale dashboardNotificationsFiltersVotes", () async {
    String dashboardNotificationsFiltersVotes = localization.dashboardNotificationsFiltersVotes();
    expect(true, dashboardNotificationsFiltersVotes != "" && dashboardNotificationsFiltersVotes != null); 
  }); 
 
  test("All methods for $locale dashboardNotificationsFiltersNotRead", () async {
    String dashboardNotificationsFiltersNotRead = localization.dashboardNotificationsFiltersNotRead();
    expect(true, dashboardNotificationsFiltersNotRead != "" && dashboardNotificationsFiltersNotRead != null); 
  }); 
 
  test("All methods for $locale dashboardTilesNearestMeetingTileMeetingIsToday", () async {
    String dashboardTilesNearestMeetingTileMeetingIsToday = localization.dashboardTilesNearestMeetingTileMeetingIsToday();
    expect(true, dashboardTilesNearestMeetingTileMeetingIsToday != "" && dashboardTilesNearestMeetingTileMeetingIsToday != null); 
  }); 
 
  test("All methods for $locale dashboardTilesNearestMeetingTileMeetingWasYesterday", () async {
    String dashboardTilesNearestMeetingTileMeetingWasYesterday = localization.dashboardTilesNearestMeetingTileMeetingWasYesterday();
    expect(true, dashboardTilesNearestMeetingTileMeetingWasYesterday != "" && dashboardTilesNearestMeetingTileMeetingWasYesterday != null); 
  }); 
 
  test("All methods for $locale dashboardTilesNearestMeetingTileMeetingIsTomorrow", () async {
    String dashboardTilesNearestMeetingTileMeetingIsTomorrow = localization.dashboardTilesNearestMeetingTileMeetingIsTomorrow();
    expect(true, dashboardTilesNearestMeetingTileMeetingIsTomorrow != "" && dashboardTilesNearestMeetingTileMeetingIsTomorrow != null); 
  }); 
 
  test("All methods for $locale dashboardTilesNearestMeetingTileMeetingInDays", () async {
    String dashboardTilesNearestMeetingTileMeetingInDays = localization.dashboardTilesNearestMeetingTileMeetingInDays();
    expect(true, dashboardTilesNearestMeetingTileMeetingInDays != "" && dashboardTilesNearestMeetingTileMeetingInDays != null); 
  }); 
 
  test("All methods for $locale dashboardTilesNearestMeetingTileDays", () async {
    String dashboardTilesNearestMeetingTileDays = localization.dashboardTilesNearestMeetingTileDays();
    expect(true, dashboardTilesNearestMeetingTileDays != "" && dashboardTilesNearestMeetingTileDays != null); 
  }); 
 
  test("All methods for $locale settingsSettingsTitle", () async {
    String settingsSettingsTitle = localization.settingsSettingsTitle();
    expect(true, settingsSettingsTitle != "" && settingsSettingsTitle != null); 
  }); 
 
  test("All methods for $locale settingsButtonLogout", () async {
    String settingsButtonLogout = localization.settingsButtonLogout();
    expect(true, settingsButtonLogout != "" && settingsButtonLogout != null); 
  }); 
 
  test("All methods for $locale settingsSwitchTechnicalData", () async {
    String settingsSwitchTechnicalData = localization.settingsSwitchTechnicalData();
    expect(true, settingsSwitchTechnicalData != "" && settingsSwitchTechnicalData != null); 
  }); 
 
  test("All methods for $locale settingsSwitchWakelockTimeline", () async {
    String settingsSwitchWakelockTimeline = localization.settingsSwitchWakelockTimeline();
    expect(true, settingsSwitchWakelockTimeline != "" && settingsSwitchWakelockTimeline != null); 
  }); 
 
  test("All methods for $locale settingsHallOfFameTitle", () async {
    String settingsHallOfFameTitle = localization.settingsHallOfFameTitle();
    expect(true, settingsHallOfFameTitle != "" && settingsHallOfFameTitle != null); 
  }); 
 
  test("All methods for $locale filtersTitle", () async {
    String filtersTitle = localization.filtersTitle();
    expect(true, filtersTitle != "" && filtersTitle != null); 
  }); 
 
  test("All methods for $locale filtersFiltersDateFrom", () async {
    String filtersFiltersDateFrom = localization.filtersFiltersDateFrom();
    expect(true, filtersFiltersDateFrom != "" && filtersFiltersDateFrom != null); 
  }); 
 
  test("All methods for $locale filtersFiltersDateTo", () async {
    String filtersFiltersDateTo = localization.filtersFiltersDateTo();
    expect(true, filtersFiltersDateTo != "" && filtersFiltersDateTo != null); 
  }); 
 
  test("All methods for $locale filtersFiltersSearchPhrase", () async {
    String filtersFiltersSearchPhrase = localization.filtersFiltersSearchPhrase();
    expect(true, filtersFiltersSearchPhrase != "" && filtersFiltersSearchPhrase != null); 
  }); 
 
  test("All methods for $locale filtersFiltersSubscribed", () async {
    String filtersFiltersSubscribed = localization.filtersFiltersSubscribed();
    expect(true, filtersFiltersSubscribed != "" && filtersFiltersSubscribed != null); 
  }); 
 
  test("All methods for $locale sortTitle", () async {
    String sortTitle = localization.sortTitle();
    expect(true, sortTitle != "" && sortTitle != null); 
  }); 
 
  test("All methods for $locale sortAscending", () async {
    String sortAscending = localization.sortAscending();
    expect(true, sortAscending != "" && sortAscending != null); 
  }); 
 
  test("All methods for $locale sortDescending", () async {
    String sortDescending = localization.sortDescending();
    expect(true, sortDescending != "" && sortDescending != null); 
  }); 
 
}
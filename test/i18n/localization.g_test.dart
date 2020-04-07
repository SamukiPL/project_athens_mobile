import 'dart:convert';
import 'dart:io';

import 'package:projectathens/i18n/localization.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String scriptPath = Platform.script.path;
  String filePathForCoverage = '/' + scriptPath.substring(0, scriptPath.indexOf('test')).substring(1) + 'resources/lang/';

  File plFile = File(filePathForCoverage + 'pl.json');
  String plData = plFile.readAsStringSync();
  Map<String, dynamic> plWords = json.decode(plData);
  testAllMethods('pl', AppLocalizationsGenerated(plWords));

  File enFile = File(filePathForCoverage + 'en.json');
  String enData = enFile.readAsStringSync();
  Map<String, dynamic> enWords = json.decode(enData);
  testAllMethods('en', AppLocalizationsGenerated(enWords));
}

void testAllMethods(String locale, AppLocalizationsGenerated localization) {
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
 
  test("All methods for $locale loginHintsEmail", () async {
    String loginHintsEmail = localization.loginHintsEmail();
    expect(true, loginHintsEmail != "" && loginHintsEmail != null); 
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
 
  test("All methods for $locale loginValidateFillEmail", () async {
    String loginValidateFillEmail = localization.loginValidateFillEmail();
    expect(true, loginValidateFillEmail != "" && loginValidateFillEmail != null); 
  }); 
 
  test("All methods for $locale loginValidateFillPassword", () async {
    String loginValidateFillPassword = localization.loginValidateFillPassword();
    expect(true, loginValidateFillPassword != "" && loginValidateFillPassword != null); 
  }); 
 
  test("All methods for $locale loginValidateFillAll", () async {
    String loginValidateFillAll = localization.loginValidateFillAll();
    expect(true, loginValidateFillAll != "" && loginValidateFillAll != null); 
  }); 
 
  test("All methods for $locale loginValidateIncorrectEmail", () async {
    String loginValidateIncorrectEmail = localization.loginValidateIncorrectEmail();
    expect(true, loginValidateIncorrectEmail != "" && loginValidateIncorrectEmail != null); 
  }); 
 
  test("All methods for $locale loginValidateWrongData", () async {
    String loginValidateWrongData = localization.loginValidateWrongData();
    expect(true, loginValidateWrongData != "" && loginValidateWrongData != null); 
  }); 
 
}
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';

enum RegistrationStep {
  ACCOUNT_INFO, REGISTRATION_END, DEPUTIES_CHOOSER
}

extension RegistrationStepExt on RegistrationStep {

  String getCurrentStepTitle(AppLocalizations localization) {
    switch(this) {
      case RegistrationStep.ACCOUNT_INFO:
        return "Dane Konta";
      // case RegistrationStep.TERMS_AND_CONDITIONS:
      //   return "Akceptacja regulaminu";
      case RegistrationStep.REGISTRATION_END:
        return "Dokończenie rejestracji";
      case RegistrationStep.DEPUTIES_CHOOSER:
        return "Wybór Posłów";
      default:
        throw ArgumentError("Should never occur");
    }
  }

  String getNextStepTitle(AppLocalizations localization) {
    switch(this) {
      case RegistrationStep.ACCOUNT_INFO:
        return "Następnie: Dokończenie rejestracji";
      // case RegistrationStep.TERMS_AND_CONDITIONS:
      //   return "Następnie: Dokończenie rejestracji";
      case RegistrationStep.REGISTRATION_END:
        return "Następnie: Wybór Posłów";
      default:
        return "";
    }
  }

  String getPositiveButtonText(AppLocalizations localization) {
    switch(this) {
      case RegistrationStep.ACCOUNT_INFO:
        return localization.getText().universalNext();
      // case RegistrationStep.TERMS_AND_CONDITIONS:
      //   return localization.getText().universalNext();
      case RegistrationStep.REGISTRATION_END:
        return localization.getText().loginButtonsSignUp();
      case RegistrationStep.DEPUTIES_CHOOSER:
        return localization.getText().universalChoose();
      default:
        throw ArgumentError("Should never occur");
    }
  }

  String getNegativeButtonText(AppLocalizations localization) {
    switch(this) {
      case RegistrationStep.ACCOUNT_INFO:
        return localization.getText().universalCancel();
      // case RegistrationStep.TERMS_AND_CONDITIONS:
      //   return localization.getText().universalCancel();
      case RegistrationStep.REGISTRATION_END:
        return localization.getText().universalBack();
      case RegistrationStep.DEPUTIES_CHOOSER:
        return localization.getText().universalSkip();
      default:
        throw ArgumentError("Should never occur");
    }
  }

  IconData? getStepIcon() {
    switch(this) {
      case RegistrationStep.DEPUTIES_CHOOSER:
        return Icons.search;
        break;
      default:
        return null;
        break;
    }
  }

}
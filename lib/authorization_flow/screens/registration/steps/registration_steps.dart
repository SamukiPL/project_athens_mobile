import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_step.dart';

enum RegistrationStep {
  ACCOUNT_INFO, REGISTRATION_END, DEPUTIES_CHOOSER
}

extension RegistrationStepExt on RegistrationStep {

  String getCurrentStepTitle(AppLocalizations localization) {
    switch(this) {
      case RegistrationStep.ACCOUNT_INFO:
        return "Dane Konta";
        break;
      case RegistrationStep.REGISTRATION_END:
        return "Dokończenie rejestracji";
        break;
      case RegistrationStep.DEPUTIES_CHOOSER:
        return "Wybór Posłów";
        break;
      default:
        throw ArgumentError("Should never occur");
        break;
    }
  }

  String getNextStepTitle(AppLocalizations localization) {
    switch(this) {
      case RegistrationStep.ACCOUNT_INFO:
        return "Następnie: Dokończenie rejestracji";
        break;
      case RegistrationStep.REGISTRATION_END:
        return "Następnie: Wybór Posłów";
        break;
      default:
        return "";
        break;
    }
  }

  String getPositiveButtonText(AppLocalizations localization) {
    switch(this) {
      case RegistrationStep.ACCOUNT_INFO:
        return localization.getText().universalNext();
        break;
      case RegistrationStep.REGISTRATION_END:
        return localization.getText().loginButtonsSignUp();
        break;
      case RegistrationStep.DEPUTIES_CHOOSER:
        return localization.getText().universalChoose();
        break;
      default:
        throw ArgumentError("Should never occur");
        break;
    }
  }

  String getNegativeButtonText(AppLocalizations localization) {
    switch(this) {
      case RegistrationStep.ACCOUNT_INFO:
        return localization.getText().universalCancel();
        break;
      case RegistrationStep.REGISTRATION_END:
        return localization.getText().universalBack();
        break;
      case RegistrationStep.DEPUTIES_CHOOSER:
        return localization.getText().universalSkip();
        break;
      default:
        throw ArgumentError("Should never occur");
        break;
    }
  }

}
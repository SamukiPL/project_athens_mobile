import 'package:project_athens/athens_core/i18n/localization.dart';

enum RegistrationStep {
  ACCOUNT_INFO, PASSWORD_AND_PERSONAL_INFO, DEPUTIES_CHOOSER
}

extension RegistrationStepExt on RegistrationStep {
  String getCurrentStepTitle(AppLocalizations localization) {
    switch(this) {
      case RegistrationStep.ACCOUNT_INFO:
        return "Dane Konta";
        break;
      case RegistrationStep.PASSWORD_AND_PERSONAL_INFO:
        return "Hasło, Imie i Nazwisko";
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
        return "Następnie: Hasło, Imię i Nazwisko";
        break;
      case RegistrationStep.PASSWORD_AND_PERSONAL_INFO:
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
      case RegistrationStep.PASSWORD_AND_PERSONAL_INFO:
        return localization.getText().loginButtonsRegister();
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
      case RegistrationStep.PASSWORD_AND_PERSONAL_INFO:
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
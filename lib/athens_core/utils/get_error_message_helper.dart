import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';

String getErrorMessage(ErrorType erorrType, AppLocalizations l10n) {
  switch (erorrType) {
    case ErrorType.NETWORK:
      return l10n.getText().universalErrorNetwork();
    case ErrorType.SERVER:
      return l10n.getText().universalErrorServer();
    case ErrorType.UNKNOWN:
      return l10n.getText().universalErrorUnknown();
    case ErrorType.AUTH:
      return l10n.getText().universalErrorAuth();
    default:
      return "";
  }
}

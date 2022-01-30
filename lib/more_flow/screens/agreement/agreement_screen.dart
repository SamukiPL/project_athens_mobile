import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/agreement/agreement_widget.dart';
import 'package:project_athens/athens_core/presentation/agreement/agreement_widget_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/more_flow/screens/agreement/agreement_screen_bloc.dart';
import 'package:provider/provider.dart';

class AgreementScreen extends BaseScreen<AgreementScreenBloc> {
  @override
  bool get showBackArrow => true;

  @override
  bool get shouldShowBottomBar => false;

  String getAppBarTitle(AppLocalizations localizations, AgreementScreenBloc bloc) {
    return localizations.getText().moreTermsAndAgreement();
  }

  @override
  Widget buildBody(BuildContext context, AgreementScreenBloc bloc) {
    return AgreementWidget(
        l10n: Provider.of<AppLocalizations>(context),
        shouldHandleAccept: false,
        readonly: true,
        bloc: Provider.of<AgreementWidgetBloc>(context)
    );
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, AgreementScreenBloc bloc) {
    return null;
  }
}

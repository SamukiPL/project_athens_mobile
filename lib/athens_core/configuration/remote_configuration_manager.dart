import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration_manager_bloc.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/agreement/agreement.dart';
import 'package:project_athens/athens_core/presentation/agreement/agreement_bloc.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:provider/provider.dart';

class RemoteConfigurationManager extends StatefulWidget {
  final RemoteConfigurationManagerBloc bloc;

  RemoteConfigurationManager({
    Key? key,
    required this.child,
    required this.bloc
  }) : super(key: key);

  final Widget child;

  @override
  _RemoteConfigurationManagerState createState() =>
      _RemoteConfigurationManagerState(bloc);
}

class _RemoteConfigurationManagerState extends State<RemoteConfigurationManager> with WidgetsBindingObserver, RedirectionDelegate {

  final RemoteConfigurationManagerBloc bloc;

  bool shouldRunCupertinoUpdate = false;
  bool shouldShowUpdatedPrivacyPolicy = false;

  _RemoteConfigurationManagerState(this.bloc);

  @override
  void initState() {
    super.initState();

    bloc.checkForInitialAgreement();

    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      bloc.forceRefreshConfig();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: bloc,
      child: Consumer<RemoteConfigurationManagerBloc>(
        builder: (context, bloc, _) {
          if (bloc.showUpdateDialog) {
            _handleShowUpdateDialog(context);
          } else if (bloc.showUpdatedPrivacyPolicy) {
            return _handleShowUpdatePrivacyPolicyDialog(context);
          }

          return widget.child;
        },
      ),
    );
  }

  _handleShowUpdateDialog(BuildContext context) {
    final AppLocalizations localizations = Provider.of<AppLocalizations>(context);

    if (Platform.isAndroid) {
      bloc.handleAndroid();
    } else if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
              title: Text(bloc.getCupertinoUpdateTitle(localizations)),
              content: Text(bloc.getCupertinoUpdateContent(localizations)),
              actions: _getCupertinoUpdateActions(localizations)
            ),
            barrierDismissible: !bloc.isCriticalUpdate
      );
    }
  }

  List<CupertinoDialogAction> _getCupertinoUpdateActions(AppLocalizations localizations) {
    final List<CupertinoDialogAction> actions = [
      CupertinoDialogAction(
        child: Text(
            localizations.getText().universalUpdateCupertinoDialogButtonUpdateNow()
        ),
        onPressed: () => bloc.launchAppStore(),
      )
    ];

    if (!bloc.isCriticalUpdate) {
      actions.insert(
          0,
          CupertinoDialogAction(
            child: Text(
                localizations.getText().universalUpdateCupertinoDialogButtonLater()
            ),
          )
      );
    }

    return actions;
  }

  _handleShowUpdatePrivacyPolicyDialog(BuildContext context) {
    final AgreementBloc _agreementBloc = Provider.of<AgreementBloc>(context);
    final AppLocalizations l10n = Provider.of<AppLocalizations>(context);

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(l10n.getText().universalAgreementTitle(), style: TextStyle(color: Colors.white),),
      ),
      body: Agreement(
          shouldHandleAccept: true,
          l10n: l10n,
          onConfirm: (bool confirmed) async {
            bloc.resetAgreementFlag();
            bloc.forceRefreshConfig();
          },
          bloc: _agreementBloc
      )
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    bloc.dispose();

    super.dispose();
  }
}
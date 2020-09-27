import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/settings_flow/screens/settings/settings_bloc.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends BaseScreen<SettingsBloc> {
  @override
  String get appBarTitle => "Settings";
  @override
  bool get showBackArrow => false;

  @override
  Widget buildBody(BuildContext context, SettingsBloc bloc) {
    final localization = Provider.of<AppLocalizations>(context);
    return Container(
      child: MaterialButton(
        onPressed: () {
          bloc.logout();
        },
        child: Text(localization.getText().settingsButtonLogout()),
      ),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, SettingsBloc bloc) {
    return null;
  }

  @override
  void onSuccess(BuildContext context) {
    var appNavigation = Provider.of<AppNavigation>(context, listen: false);
    appNavigation.goToLoginWidget(context);
  }

}
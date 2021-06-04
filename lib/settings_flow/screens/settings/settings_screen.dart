import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/configuration/configuration.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/settings_flow/screens/settings/settings_bloc.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends BaseScreen<SettingsBloc> {

  @override
  bool get showBackArrow => false;
  @override
  bool get shouldShowBottomBar => true;

  String getAppBarTitle(AppLocalizations localizations, SettingsBloc bloc) {
    return localizations.getText().settingsSettingsTitle();
  }

  @override
  Widget buildBody(BuildContext context, SettingsBloc bloc) {
    final localization = Provider.of<AppLocalizations>(context);
    final configuration = Provider.of<Configuration>(context);

    return Container(
        child: Column(
      children: [
        MaterialButton(
          onPressed: () {
            bloc.logout();
          },
          child: Text(localization.getText().settingsButtonLogout()),
        ),
        Row(
          children: [
            StreamProvider.value(
                value: configuration.showTechnicalData,
                initialData: false,
                child: Consumer<bool>(
                    builder: (BuildContext context, bool value, Widget child) =>
                        Switch(
                            value: value,
                            onChanged: configuration.updateShowTechnicalData))),
            Text(localization.getText().settingsSwitchTechnicalData()),
          ],
        ),
        Row(
          children: [
            StreamProvider.value(
                value: configuration.wakelockOnTimeline,
                initialData: false,
                child: Consumer<bool>(
                    builder: (BuildContext context, bool value, Widget child) =>
                        Switch(
                            value: value,
                            onChanged: configuration.updateWakelockOnTimeline))),
            Text(localization.getText().settingsSwitchWakelockTimeline()),
          ],
        ),
        Expanded(child: Container()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Podoba Ci się aplikacja?'),
            MaterialButton(
                onPressed: () => bloc.goToCrowdFundingPage(),
                child: Text(
                    "Wesprzyj nas ❤",
                    style: TextStyle(
                      color: Color.fromRGBO(230, 65, 100, 1)
                    ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(color: Color.fromRGBO(230, 65, 100, 1))
                ),

            )
          ]
        )
      ],
    ));
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

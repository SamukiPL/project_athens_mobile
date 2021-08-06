import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/configuration/configuration.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/more_flow/screens/settings/settings_bloc.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends BaseScreen<SettingsBloc> {

  @override
  bool get showBackArrow => true;

  @override
  bool get shouldShowBottomBar => false;

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
        Row(
          children: [
            StreamProvider.value(
                value: configuration.showTechnicalData,
                initialData: false,
                child: Consumer<bool>(
                    builder: (BuildContext context, bool value, Widget? child) =>
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
                    builder: (BuildContext context, bool value, Widget? child) =>
                        Switch(
                            value: value,
                            onChanged: configuration.updateWakelockOnTimeline))),
            Text(localization.getText().settingsSwitchWakelockTimeline()),
          ],
        )
      ],
    ));
  }

  @override
  Widget? buildFloatingActionButton(BuildContext context, SettingsBloc bloc) {
    return null;
  }

  @override
  void onSuccess(BuildContext context) {
    var appNavigation = Provider.of<AppNavigation>(context, listen: false);
    appNavigation.goToLoginWidget(context);
  }
}

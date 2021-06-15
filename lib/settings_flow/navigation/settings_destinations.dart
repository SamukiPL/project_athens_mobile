import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/main/injections/app_navigation_module.dart';
import 'package:project_athens/settings_flow/injections/settings_module.dart';
import 'package:project_athens/settings_flow/screens/hall_of_fame/hall_of_fame_screen.dart';
import 'package:project_athens/settings_flow/screens/settings/settings_screen.dart';

class SettingsScreenDestination extends Destination<SettingsScreen> {

  SettingsScreenDestination() : super(BottomNavItem.SETTINGS);

  @override
  SettingsScreen getScreen() => SettingsScreen();

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [SettingsModule(context), AppNavigationModule(context)];
}

class SettingsHallOfFameScreenDestination extends Destination<HallOfFameScreen> {
  SettingsHallOfFameScreenDestination() : super(BottomNavItem.SETTINGS);

  @override
  HallOfFameScreen getScreen() => HallOfFameScreen();

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [SettingsModule(context), AppNavigationModule(context)];
}
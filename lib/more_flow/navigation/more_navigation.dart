import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/main/injections/app_navigation_module.dart';
import 'package:project_athens/more_flow/injections/credits_module.dart';
import 'package:project_athens/more_flow/injections/hall_of_fame_module.dart';
import 'package:project_athens/more_flow/injections/more_module.dart';
import 'package:project_athens/more_flow/injections/settings_module.dart';
import 'package:project_athens/more_flow/screens/credits/credits_screen.dart';
import 'package:project_athens/more_flow/screens/hall_of_fame/hall_of_fame_screen.dart';
import 'package:project_athens/more_flow/screens/more/more_screen.dart';
import 'package:project_athens/more_flow/screens/settings/settings_screen.dart';

class MoreScreenDestination extends Destination<MoreScreen> {
  MoreScreenDestination() : super(BottomNavItem.DASHBOARD);

  @override
  MoreScreen getScreen() => MoreScreen();

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [MoreModule(context), AppNavigationModule(context)];
}

class MoreHallOfFameScreenDestination extends Destination<HallOfFameScreen> {
  MoreHallOfFameScreenDestination() : super(BottomNavItem.DASHBOARD);

  @override
  HallOfFameScreen getScreen() => HallOfFameScreen();

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [HallOfFameModule(context)];
}

class MoreSettingsScreenDestination extends Destination<SettingsScreen> {
  MoreSettingsScreenDestination() : super(BottomNavItem.DASHBOARD);

  @override
  SettingsScreen getScreen() => SettingsScreen();

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [SettingsModule(context), AppNavigationModule(context)];
}

class MoreCreditsScreenDestination extends Destination<CreditsScreen> {
  MoreCreditsScreenDestination() : super(BottomNavItem.MORE);

  @override
  CreditsScreen getScreen() => CreditsScreen();

  @override getScreenModules(BuildContext context) =>
      [CreditsModule(context)];
}
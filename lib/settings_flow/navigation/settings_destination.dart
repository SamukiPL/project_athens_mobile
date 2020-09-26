import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/settings_flow/injections/settings_module.dart';
import 'package:project_athens/settings_flow/screens/settings/settings_screen.dart';

abstract class SettingsDestination<SCREEN extends BaseScreen> extends Destination<SCREEN> {}

class SettingsScreenDestination extends SettingsDestination<SettingsScreen> {
  @override
  void dispose() {}

  @override
  SettingsScreen getScreen() => SettingsScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [SettingsModule(context)];

}


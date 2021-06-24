import 'package:project_athens/athens_core/auto_updater/auto_updater.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/main/navigation/app_navigation_impl.dart';
import 'package:provider/provider.dart';

class AppNavigationModule extends Module {

  AppNavigationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    return [
      Provider<AppNavigation>(
        create: (context) => AppNavigationImpl(),
      )
    ];
  }

}
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:nested/nested.dart';
import 'package:project_athens/main/navigation/app_navigation_impl.dart';
import 'package:project_athens/main/navigation/fluro_router.dart';
import 'package:provider/provider.dart';

class AppNavigationModule extends Module {

  AppNavigationModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    var router = FluroRouter(Router()).createRouter();
    return [
      Provider<AppNavigation>(
        create: (context) => AppNavigationImpl(router),
      )
    ];
  }

}
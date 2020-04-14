import 'package:athens_core/injections/module_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/injections/app_navigation_module.dart';

import 'package:splash_screen/splash_screen_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Fimber.plantTree(DebugBufferTree());
    return MaterialApp(
      title: 'Project Athens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ModuleWidget(
        providers: [AppNavigationModule(context)],
        child: SplashScreenWidget(),
      ),
    );
  }
}

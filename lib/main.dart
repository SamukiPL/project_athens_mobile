import 'package:athens_core/injections/module_widget.dart';
import 'package:authorization_flow/login_widget.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/injections/app_module.dart';

import 'package:splash_screen/splash_screen_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Athens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ModuleWidget(
        providers: [AppModule(context)],
        child: SplashScreenWidget(),
      ),
    );
  }
}

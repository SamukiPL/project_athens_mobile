import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_athens/athens_core/i18n/localization_module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/authorization_flow/login_widget.dart';
import 'package:project_athens/main/injections/app_navigation_module.dart';
import 'package:project_athens/main/presentation/main_widget.dart';


class AppNavigationImpl implements AppNavigation {
  @override
  void goToLoginWidget(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ModuleWidget(
                  providers: [
                    AppNavigationModule(context),
                    LocalizationModule(context)
                  ],
                  child: LoginWidget(),
                )));
  }

  @override
  void goToMainWidget(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainWidget()));
  }
}

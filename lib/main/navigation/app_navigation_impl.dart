import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/auto_updater/auto_updater_module.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/db/database_module.dart';
import 'package:project_athens/athens_core/i18n/localization_module.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/athens_core/presentation/agreement/injections/agreement_module.dart';
import 'package:project_athens/authorization_flow/login_widget.dart';
import 'package:project_athens/main/presentation/main_widget.dart';


class AppNavigationImpl implements AppNavigation {
  @override
  void goToLoginWidget(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ModuleWidget(
                  providers: [
                    NetworkModule(context),
                    LocalizationModule(context),
                    AgreementModule(context),
                    AutoUpdaterModule(context)
                  ],
                  child: LoginWidget(),
                  )
                ));
  }

  @override
  void goToMainWidget(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ModuleWidget(
                providers: [
                  NetworkModule(context),
                  LocalizationModule(context),
                  AgreementModule(context),
                  AutoUpdaterModule(context),
                  DatabaseModule(context)
                ],
                child: MainWidget(),
            )
        )
    );
  }
}

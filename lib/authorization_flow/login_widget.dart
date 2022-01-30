import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration_manager.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration_manager_bloc.dart';
import 'package:project_athens/athens_core/injections/module_widget.dart';
import 'package:project_athens/authorization_flow/injections/login_widget_module.dart';
import 'package:project_athens/authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:project_athens/authorization_flow/screens/login/login_screen.dart';
import 'package:project_athens/authorization_flow/screens/registration/registration_screen.dart';
import 'package:project_athens/authorization_flow/screens/reset_password/reset_password_screen.dart';
import 'package:provider/provider.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RemoteConfiguration config = Provider.of<RemoteConfiguration>(context);
    final RemoteConfigurationManagerBloc bloc = RemoteConfigurationManagerBloc(config);

    return RemoteConfigurationManager(
        bloc: bloc,
        child: ModuleWidget(
          providers: [LoginWidgetModule(context)],
          child: Consumer<LoginNavigationBloc>(
            builder: (context, navigation, _) => WillPopScope(
              onWillPop: () async {
                return navigation.goBack();
              },
              child: _getScreen(context, navigation.currentScreen),
            ),
          ),
        )
    );
  }

  Widget _getScreen(
      BuildContext context, LoginDestination destination) {
    switch (destination) {
      case LoginDestination.REGISTER:
        return RegistrationScreen();
      case LoginDestination.RESET_PASSWORD:
        return ResetPasswordScreen();
      default:
        return LoginScreen();
    }
  }
}

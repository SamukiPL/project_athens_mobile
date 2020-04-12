import 'package:athens_core/chopper/network_module_simple.dart';
import 'package:authorization_flow/injections/login_widget_module.dart';
import 'package:authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:athens_core/injections/module_widget.dart';
import 'package:authorization_flow/screens/login/login_screen.dart';
import 'package:authorization_flow/screens/registration/registration_screen.dart';
import 'package:authorization_flow/screens/password_reset/password_reset_screen.dart';

class LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModuleWidget(
      providers: [LoginWidgetModule(context), NetworkModuleSimple(context)],
      child: Consumer<LoginNavigationBloc>(
        builder: (context, navigation, _) => Container(
          child: _getScreen(navigation.currentScreen),
        ),
      ),
    );
  }

  StatelessWidget _getScreen(LoginDestination destination) {
    switch (destination) {
      case LoginDestination.REGISTER:
        return RegistrationScreen();
        break;
      case LoginDestination.RESET_PASSWORD:
        return PasswordResetScreen();
        break;
      default:
        return LoginScreen();
        break;
    }
  }
}

import 'package:athens_core/injections/module.dart';
import 'package:athens_core/navigation/app_navigation.dart';
import 'package:authorization_flow/injections/login_screen_module.dart';
import 'package:authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:authorization_flow/screens/base_login_screen.dart';
import 'package:authorization_flow/screens/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends BaseLoginScreen<LoginBloc> {

  @override
  List<Module> getProviders(BuildContext context) => [LoginScreenModule(context)];

  @override
  Widget generateBody(BuildContext context, LoginBloc bloc) {
    var loginNavigation = Provider.of<LoginNavigationBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          onChanged: (login) => bloc.setLogin(login),
          textInputAction: TextInputAction.next,
        ),
        TextFormField(
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          onChanged: (password) => bloc.setPassword(password),
          textInputAction: TextInputAction.done,
          onEditingComplete: () => bloc(),
        ),
        MaterialButton(
          child: Text("Login"),
          onPressed: () => bloc(),
        ),
        MaterialButton(
          child: Text("Reset password"),
          onPressed: () => loginNavigation.addItem(LoginDestination.RESET_PASSWORD),
        ),
        MaterialButton(
          child: Text("Register"),
          onPressed: () => loginNavigation.addItem(LoginDestination.REGISTER),
        )
      ],
    );
  }

  @override
  Widget generateAppBar(BuildContext context, LoginBloc bloc) {
    return null;
  }

  @override
  Widget generateFab(BuildContext context, LoginBloc bloc) {
    return null;
  }

  @override
  void onAuthFailure() {
    // TODO: implement onAuthFailure
  }

  @override
  void onSuccess(BuildContext context) {
    var appNavigation = Provider.of<AppNavigation>(context);
    appNavigation.goToMainWidget(context);
  }
}

import 'package:athens_core/injections/module.dart';
import 'package:athens_core/navigation/app_navigation.dart';
import 'package:authorization_flow/injections/reset_password_module.dart';
import 'package:authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:authorization_flow/screens/base_login_screen.dart';
import 'package:authorization_flow/screens/reset_password/reset_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends BaseLoginScreen<ResetPasswordBloc> {
  @override
  List<Module> getProviders(BuildContext context) {
    return [ResetPasswordModule(context)];
  }

  @override
  Widget generateAppBar(BuildContext context, ResetPasswordBloc bloc) {
    final loginNavigation = Provider.of<LoginNavigationBloc>(context);
    return AppBar(
      leading: BackButton(
        onPressed: () => loginNavigation.goBack(),
      ),
      title: Text("Reset"),
    );
  }

  @override
  Widget generateBody(BuildContext context, ResetPasswordBloc bloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          onChanged: (email) => bloc.setEmail(email),
          textInputAction: TextInputAction.done,
          onEditingComplete: () => bloc(),
        ),
        MaterialButton(
          child: Text("Reset"),
          onPressed: () => bloc(),
        ),
      ],
    );
  }

  @override
  Widget generateFab(BuildContext context, ResetPasswordBloc bloc) {
    return null;
  }

  @override
  void onAuthFailure() {
    // TODO: implement onAuthFailure
  }

  @override
  void onSuccess(BuildContext context) {
    var loginNavigation = Provider.of<LoginNavigationBloc>(context, listen: false);
    loginNavigation.setItem(LoginDestination.LOGIN);
  }
}

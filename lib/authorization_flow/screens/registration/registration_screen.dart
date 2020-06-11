import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/authorization_flow/injections/registration_module.dart';
import 'package:project_athens/authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:project_athens/authorization_flow/screens/base_login_screen.dart';
import 'package:project_athens/authorization_flow/screens/registration/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends BaseLoginScreen<RegistrationBloc> {

  @override
  Widget generateAppBar(BuildContext context, RegistrationBloc bloc) {
    final loginNavigation = Provider.of<LoginNavigationBloc>(context);
    return AppBar(
      leading: BackButton(
        onPressed: () => loginNavigation.goBack(),
      ),
      title: Text("Registration"),
    );
  }

  @override
  Widget generateBody(BuildContext context, RegistrationBloc bloc) {
    return Column(
      children: <Widget>[
        TextFormField(
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          onChanged: (login) => bloc.setFirstName(login),
          textInputAction: TextInputAction.next,
        ),
        TextFormField(
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          onChanged: (login) => bloc.setLastName(login),
          textInputAction: TextInputAction.next,
        ),
        TextFormField(
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          onChanged: (login) => bloc.setLogin(login),
          textInputAction: TextInputAction.next,
        ),
        TextFormField(
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          onChanged: (login) => bloc.setEmail(login),
          textInputAction: TextInputAction.next,
        ),
        TextFormField(
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          onChanged: (password) => bloc.setPassword(password),
          textInputAction: TextInputAction.next,
        ),
        TextFormField(
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          onChanged: (password) => bloc.setRepeatPassword(password),
          textInputAction: TextInputAction.done,
          onEditingComplete: () => bloc(),
        ),
        MaterialButton(
          child: Text("Login"),
          onPressed: () => bloc(),
        ),
      ],
    );
  }

  @override
  Widget generateFab(BuildContext context, RegistrationBloc bloc) {
    return null;
  }

  @override
  List<Module> getProviders(BuildContext context) {
    return [RegistrationModule(context)];
  }

  @override
  void onAuthFailure() {
    // TODO: implement onAuthFailure
  }

  @override
  void onSuccess(BuildContext context) {
    var loginNavigation = Provider.of<LoginNavigationBloc>(context, listen: false);
    loginNavigation.setItem(LoginDestination.REGISTER_DEPUTIES);
  }

}

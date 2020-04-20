import 'package:athens_core/injections/module_widget.dart';
import 'package:authorization_flow/injections/registration_module.dart';
import 'package:authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:authorization_flow/screens/registration/registration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../base_login_bloc.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginNavigation = Provider.of<LoginNavigationBloc>(context);
    return ModuleWidget(
      providers: [RegistrationModule(context)],
      child: Consumer<RegistrationBloc>(
        builder: (context, bloc, _) => Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () => loginNavigation.goBack(),
            ),
            title: Text("Registration"),
          ),
          body: _generateBody(context, bloc),
        ),
      ),
    );
  }

  Widget _generateBody(BuildContext context, RegistrationBloc bloc) {
    var loginNavigation = Provider.of<LoginNavigationBloc>(context);
    bloc.state.listen((state) {
      if (state == ScreenState.SUCCESS) {
        loginNavigation.setItem(LoginDestination.REGISTER_DEPUTIES);
      }
    });
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

}

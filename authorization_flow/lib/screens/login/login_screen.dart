import 'package:authorization_flow/injections/login_screen_module.dart';
import 'package:authorization_flow/screens/login/login_bloc.dart';
import 'package:athens_core/injections/module_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ModuleWidget(
      providers: [LoginScreenModule(context)],
      child: Consumer<LoginBloc>(
        builder: (context, bloc, _) => Scaffold(
          body: Column(
            children: <Widget>[
              TextFormField(
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                onChanged: (login) => bloc.setLogin(login),
              ),
              TextFormField(
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                onChanged: (password) => bloc.setPassword(password),
              ),
              MaterialButton(
                child: Text("Login"),
                onPressed: () => bloc.logIn(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:athens_core/navigation/app_navigation.dart';
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
        builder: (context, bloc, _) =>
            Scaffold(
              body: _generateBody(context, bloc),
            ),
      ),
    );
  }

  Widget _generateBody(BuildContext context, LoginBloc bloc) {
    var appNavigation = Provider.of<AppNavigation>(context);
    bloc.state.listen((state) {
      if (state == LoginScreenState.SUCCESS) {
        appNavigation.goToMainWidget(context);
      }
    });
    return Column(
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
    );
  }
}

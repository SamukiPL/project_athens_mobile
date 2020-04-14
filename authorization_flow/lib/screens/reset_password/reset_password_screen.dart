import 'package:athens_core/injections/module_widget.dart';
import 'package:athens_core/navigation/app_navigation.dart';
import 'package:authorization_flow/injections/reset_password_module.dart';
import 'package:authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:authorization_flow/screens/base_login_bloc.dart';
import 'package:authorization_flow/screens/reset_password/reset_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginNavigation = Provider.of<LoginNavigationBloc>(context);
    return ModuleWidget(
      providers: [ResetPasswordModule(context)],
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => loginNavigation.goBack(),
          ),
          title: Text("Reset"),
        ),
        body: Center(
          child: Consumer<ResetPasswordBloc>(
            builder: (context, bloc, _) => _buildBody(context, bloc),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ResetPasswordBloc bloc) {
    final appNavigation = Provider.of<AppNavigation>(context);
    bloc.state.listen((state) {
      if (state == ScreenState.SUCCESS)
        appNavigation.goToLoginWidget(context);
    });
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
          onChanged: (email) => bloc.setEmail(email),
        ),
        MaterialButton(
          child: Text("Reset"),
          onPressed: () => bloc.resetPassword(),
        ),
      ],
    );
  }
}

import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/authorization_flow/injections/login_screen_module.dart';
import 'package:project_athens/authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:project_athens/authorization_flow/screens/base_login_screen.dart';
import 'package:project_athens/authorization_flow/screens/login/auth_failed_notifier.dart';
import 'package:project_athens/authorization_flow/screens/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends BaseLoginScreen<LoginBloc> {
  @override
  List<Module> getProviders(BuildContext context) =>
      [LoginScreenModule(context)];

  @override
  Widget generateBody(BuildContext context, LoginBloc bloc) {
    var localization = Provider.of<AppLocalizations>(context);
    var loginNavigation = Provider.of<LoginNavigationBloc>(context);
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(92, 0, 92, 0),
          child: Image.asset("resources/images/logo.png"),
        ),
        ChangeNotifierProvider<AuthFailedNotifier>.value(
          value: bloc.authFailedNotifier,
          child: Consumer<AuthFailedNotifier>(
            builder: (context, authFailed, _) => bloc.authFailedNotifier.hasFailed ? AnimatedContainer(
              margin: EdgeInsets.fromLTRB(32, 8, 32, 8),
              width: double.infinity,
              height: bloc.authFailed ? 0 : 50,
              duration: Duration(seconds: 2),
              curve: Curves.bounceIn,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: theme.errorColor.withOpacity(0.6),
                border: Border.all(
                  color: Colors.redAccent,
                  width: 2,
                  style: BorderStyle.solid
                )
              ),
              child: Center(
                child: Text(
                  localization.getText().loginErrorPasswordOrLoginDoesNotMatch(),
                  style:  TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,

                ),
              )
            ) : Container(),
          ),

        ),
        Container(
          margin: EdgeInsets.fromLTRB(32, 8, 32, 8),
          child: TextFormField(
            onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            onChanged: (login) => bloc.setLogin(login),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                labelText: localization.getText().loginHintsLogin(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
            maxLines: 1,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(32, 8, 32, 0),
          child: TextFormField(
            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            onChanged: (password) => bloc.setPassword(password),
            textInputAction: TextInputAction.done,
            onEditingComplete: () => bloc(),
            decoration: InputDecoration(
                labelText: localization.getText().loginHintsPassword(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
            maxLines: 1,
            obscureText: true
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 32),
          child: Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              onPressed: () =>
                  loginNavigation.addItem(LoginDestination.RESET_PASSWORD),
              child: Text(
                localization.getText().loginButtonsForgot(),
                style: TextStyle(color: theme.primaryColor),
              ),
            ),
          ),
        ),
        RaisedButton(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
              localization.getText().loginButtonsLogin(),
              style: TextStyle(color: Colors.white),
              textScaleFactor: 1.5,
            ),
          ),
          onPressed: () => bloc(),
          color: theme.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(localization.getText().loginOtherNotAMember()),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: MaterialButton(
                  onPressed: () =>
                      loginNavigation.addItem(LoginDestination.REGISTER),
                  child: Text(
                    localization.getText().loginButtonsRegister(),
                    style: TextStyle(color: theme.primaryColor),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(color: theme.primaryColor)
                  ),
                ),
              )
            ],
          ),
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
  void onNetworkFailure(LoginBloc bloc) {
    bloc();
  }

  @override
  void onAuthFailure(BuildContext context, LoginBloc bloc) {
    bloc.setAuthFailed(true);
  }

  @override
  void onSuccess(BuildContext context) {
    var appNavigation = Provider.of<AppNavigation>(context, listen: false);
    appNavigation.goToMainWidget(context);
  }
}

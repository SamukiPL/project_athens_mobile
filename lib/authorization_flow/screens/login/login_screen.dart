import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/athens_core/presentation/button_loader/button_loader.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/authorization_flow/injections/login_screen_module.dart';
import 'package:project_athens/authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:project_athens/authorization_flow/screens/base_login_screen.dart';
import 'package:project_athens/authorization_flow/screens/login/auth_failed_notifier.dart';
import 'package:project_athens/authorization_flow/screens/login/login_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends BaseLoginScreen<LoginBloc> {
  @override
  List<Module> getProviders(BuildContext context) =>
      [LoginScreenModule(context)];

  @override
  Widget generateBody(BuildContext context, LoginBloc bloc) {
    final l10n = Provider.of<AppLocalizations>(context);
    final theme = Theme.of(context);
    return IntrinsicHeight(
      child: SafeArea(child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () => bloc.loginAsGuest(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChangeNotifierProvider<DataLoadingBloc>.value(
                      value: bloc.loginGuestLoadingBloc,
                      child: Consumer<DataLoadingBloc>(
                        builder: (context, loadingBloc, _) {
                          if (loadingBloc.loadingState is Loading) {
                            return Container(
                              padding: EdgeInsets.only(right: 8),
                              child: SizedBox(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                                height: 16,
                                width: 16,
                              )
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                  ),
                  Text(
                    l10n.getText().loginButtonsContinueWithoutSignIn(),
                    style: TextStyle(
                        color: theme.dividerColor
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: theme.dividerColor,
                    size: 32,
                  )
                ],
              ),
            )

          ),
          Expanded(
              child: _buildForm(context, bloc)
          )
        ],
      )
    ));
  }

  Widget _buildErrorBox(
      AppLocalizations localization, LoginBloc bloc, ThemeData theme) {
    if (bloc.authFailedNotifier.hasFailed) {
      return AnimatedContainer(
          margin: EdgeInsets.fromLTRB(32, 8, 32, 8),
          width: double.infinity,
          height: bloc.authFailedNotifier.hasFailed ? 50 : 0,
          duration: Duration(seconds: 2),
          curve: Curves.bounceIn,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: theme.errorColor.withOpacity(0.6),
              border: Border.all(
                  color: Colors.redAccent, width: 2, style: BorderStyle.solid)),
          child: Center(
            child: Text(
              localization.getText().loginErrorPasswordOrLoginDoesNotMatch(),
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ));
    } else {
      return Container();
    }
  }

  Widget _buildForm(BuildContext context, LoginBloc bloc) {
    var localization = Provider.of<AppLocalizations>(context);
    var loginNavigation = Provider.of<LoginNavigationBloc>(context);
    final theme = Theme.of(context);

    return Form(
        key: bloc.loginScreenForm,
        child: Column(
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
                builder: (context, authFailed, _) =>
                    _buildErrorBox(localization, bloc, theme),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(32, 8, 32, 8),
              child: TextFormField(
                controller: bloc.textEditingController,
                onChanged: (login) => bloc.setLogin(login),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: localization.getText().loginHintsLoginOrEmail(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                maxLines: 1,
                validator: (String? login) {
                  if (login == null || login == '') return localization.getText().loginValidateFieldCannotBeEmpty();

                  return null;
                },
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
                  validator: (String? password) {
                    if (password == null || password == '') return localization.getText().loginValidateFieldCannotBeEmpty();

                    return null;
                  },
                  obscureText: true),
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
            ButtonLoader(
                bloc.loginButtonLoadingBloc,
                callback: () => bloc(),
                buttonBg: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                mainPadding: EdgeInsets.all(16),
                actionStateWidget: Container(
                  child: Text(
                    localization.getText().loginButtonsLogin(),
                    style: TextStyle(color: Colors.white),
                    textScaleFactor: 1.5,
                  ),
                )
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
                          side: BorderSide(color: theme.primaryColor)),
                    ),
                  )
                ],
              ),
            ),
            // _buildEnterAsGuest(localization, bloc, theme),
          ],
        )
    );
  }

  Widget _buildEnterAsGuest(AppLocalizations localization, LoginBloc bloc, ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: MaterialButton(
              onPressed: () => bloc.loginAsGuest(),
              child: Text(
                localization().guestLogAsGuest(),
                style: TextStyle(color: theme.primaryColor),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                  side: BorderSide(color: theme.primaryColor)),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget? generateAppBar(BuildContext context, LoginBloc bloc) {
    return null;
  }

  @override
  Widget? generateFab(BuildContext context, LoginBloc bloc) {
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
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    var appNavigation = Provider.of<AppNavigation>(context, listen: false);
    appNavigation.goToMainWidget(context, loggedState: bloc.loggedState);
  }
}

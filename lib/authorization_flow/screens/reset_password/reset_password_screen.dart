import 'package:email_validator/email_validator.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/alert_bottom_sheet/alert_bottom_sheet.dart';
import 'package:project_athens/athens_core/presentation/alert_bottom_sheet/alert_bottom_sheet_mode.dart';
import 'package:project_athens/athens_core/presentation/button_loader/button_loader.dart';
import 'package:project_athens/authorization_flow/injections/reset_password_module.dart';
import 'package:project_athens/authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:project_athens/authorization_flow/screens/base_login_screen.dart';
import 'package:project_athens/authorization_flow/screens/reset_password/reset_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends BaseLoginScreen<ResetPasswordBloc> {
  @override
  List<Module> getProviders(BuildContext context) {
    return [ResetPasswordModule(context)];
  }

  @override
  Widget generateAppBar(BuildContext context, ResetPasswordBloc bloc) {
    var localization = Provider.of<AppLocalizations>(context);
    final loginNavigation = Provider.of<LoginNavigationBloc>(context);
    return AppBar(
      leading: BackButton(
        onPressed: () => loginNavigation.goBack(),
        color: Colors.white,
      ),
      title: Text(
        localization.getText().universalBack(),
        style: TextStyle(color: Colors.white),
      ),
      elevation: 0,
    );
  }

  @override
  Widget generateBody(BuildContext context, ResetPasswordBloc bloc) {
    var localization = Provider.of<AppLocalizations>(context);

    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Image.asset(
                "resources/images/logo_white.png",
                height: 0,
                alignment: Alignment.center,
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 24, bottom: 16),
                  child: Text(
                    localization.getText().loginButtonsForgot(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                  child: Text(
                    localization.getText().loginOtherForgotRationale(),
                    style: TextStyle(
                      color: Theme.of(context).dividerColor,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(32, 8, 32, 16),
                  child: Form(
                    key: bloc.resetPasswordForm,
                    child: TextFormField(
                      onChanged: (email) => bloc.setEmail(email),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          labelText: localization.getText().loginHintsEmail(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email == null || !EmailValidator.validate(email))
                          return localization
                              .getText()
                              .loginValidateIncorrectEmail();

                        return null;
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 24),
                  child: ButtonLoader(
                    bloc.btnActionAwaitBloc,
                    actionStateWidget: Text(
                      localization.getText().loginButtonsResetPassword(),
                      style: TextStyle(color: Colors.white),
                      textScaleFactor: 1.5,
                    ),
                    callback: () => bloc(),
                    buttonBg: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    mainPadding: EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget? generateFab(BuildContext context, ResetPasswordBloc bloc) {
    return null;
  }

  @override
  void onNetworkFailure(ResetPasswordBloc bloc) {
    bloc();
  }

  @override
  void onAuthFailure(BuildContext context, ResetPasswordBloc bloc) {
    // TODO: implement onAuthFailure
  }

  @override
  void onSuccess(BuildContext context) {
    final AppLocalizations l10n =
        Provider.of<AppLocalizations>(context, listen: false);

    showAlertBottomSheet(context,
        mode: AlertBottomSheetMode.SUCCESS,
        title: l10n.getText().universalSuccess(),
        description: l10n.getText().loginOtherIfAccountExistEmailIsSent(),
        closeButtonTitle: l10n.getText().universalClose(), onClose: () {
      final loginNavigation =
          Provider.of<LoginNavigationBloc>(context, listen: false);
      loginNavigation.setItem(LoginDestination.LOGIN);
    });
  }
}

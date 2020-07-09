import 'package:project_athens/athens_core/i18n/localization.dart';
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
    var localization = Provider.of<AppLocalizations>(context);
    return AppBar(
      leading: BackButton(
        onPressed: () => loginNavigation.goBack(),
        color: Colors.white,
      ),
      title: Text(
        localization.getText().universalBack(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget generateBody(BuildContext context, RegistrationBloc bloc) {
    var localization = Provider.of<AppLocalizations>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _generateFormField(
            context,
            bloc,
            (login) => bloc.setFirstName(login),
            localization.getText().loginHintsFirstName(),
            TextInputAction.next
        ),
        _generateFormField(
            context,
            bloc,
            (login) => bloc.setLastName(login),
            localization.getText().loginHintsLastName(),
            TextInputAction.next
        ),
        _generateFormField(
            context,
            bloc,
            (login) => bloc.setLogin(login),
            localization.getText().loginHintsLogin(),
            TextInputAction.next
        ),
        _generateFormField(
            context,
            bloc,
            (login) => bloc.setEmail(login),
            localization.getText().loginHintsEmail(),
            TextInputAction.next
        ),
        _generateFormField(
            context,
            bloc,
            (login) => bloc.setPassword(login),
            localization.getText().loginHintsPassword(),
            TextInputAction.next
        ),
        _generateFormField(
            context,
            bloc,
            (login) => bloc.setRepeatPassword(login),
            localization.getText().loginHintsRepeatPassword(),
            TextInputAction.done
        ),
        RaisedButton(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Text(
              localization.getText().loginButtonsRegister(),
              style: TextStyle(color: Colors.white),
              textScaleFactor: 1.5,
            ),
          ),
          onPressed: () => bloc(),
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
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
    var loginNavigation =
        Provider.of<LoginNavigationBloc>(context, listen: false);
    loginNavigation.setItem(LoginDestination.REGISTER_DEPUTIES);
  }

  Widget _generateFormField(
          BuildContext context,
          RegistrationBloc bloc,
          ValueChanged<String> onChanged,
          String labelText,
          TextInputAction action) =>
      Container(
        margin: EdgeInsets.fromLTRB(32, 8, 32, 16),
        child: TextFormField(
          onFieldSubmitted: (_) => (action == TextInputAction.next) ? FocusScope.of(context).nextFocus() : bloc(),
          onChanged: onChanged,
          textInputAction: action,
          decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
          maxLines: 1,
        ),
      );
}

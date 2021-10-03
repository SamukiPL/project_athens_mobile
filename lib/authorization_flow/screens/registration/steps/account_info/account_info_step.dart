import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_form_key.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/show_repeat_email_notifier.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_form_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step_bloc.dart';
import 'package:provider/provider.dart';

class AccountInfoStep extends BaseRegistrationFormStep<AccountInfoStepBloc> {

  AccountInfoStep(bool fieldsEnabled) : super(fieldsEnabled);

  final RegExp loginRegex = RegExp(r'^[a-zA-z0-9]{3,32}$');
  
  @override
  Widget buildFormBody(BuildContext context, AccountInfoStepBloc bloc) {
    final localization = Provider.of<AppLocalizations>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        generateFormField(
          context: context,
          initialValue: bloc.login,
          callback: () {},
          onChanged: (login) => bloc.setLogin(login),
          validator: (login) => getBaseValidator(localization, login, customValidator: (value) {
            if (login == null || !loginRegex.hasMatch(login)) return localization.getText().loginValidateLoginIsInvalid();
            if (bloc.loginTaken) return localization.getText().loginValidateLoginIsTaken();

            return null;
          }),
          labelText: localization.getText().loginHintsLogin(),
        ),
        generateFormField(
          context: context,
          initialValue: bloc.email,
          callback: () {},
          onChanged: (email) => bloc.setEmail(email),
          validator: (email) => getBaseValidator(localization, email, customValidator: (value) {
            if (bloc.emailTaken) return localization.getText().loginValidateEmailIsTaken();
            if (!EmailValidator.validate(email)) return localization.getText().loginValidateIncorrectEmail();

            return null;
          }),
          labelText: localization.getText().loginHintsEmail(),
          keyboardType: TextInputType.emailAddress
        ),
        Consumer<ShowRepeatEmailNotifier>(
          builder: (context, animationNotifier, child) => AnimatedOpacity(
            opacity: animationNotifier.showRepeatEmail ? 1 : 0,
            curve: Curves.bounceOut,
            duration: Duration(milliseconds: 750),
            child: AnimatedContainer(
              height: animationNotifier.showRepeatEmail ? 100 : 0,
              duration: Duration(milliseconds: 150),
              child: animationNotifier.showRepeatEmail ? child : null,
            ),
          ),
          child: generateFormField(
            context: context,
            initialValue: bloc.repeatEmail,
            callback: () { bloc.invokeAction(StepAction.POSITIVE); },
            onChanged: (repeatEmail) => bloc.setRepeatEmail(repeatEmail),
            validator: (repeatEmail) => getBaseValidator(localization, repeatEmail, customValidator: (value) {
              if (value != bloc.email) return localization.getText().loginValidateEmailsDontMatch();

              return null;
            }),
            labelText: localization.getText().loginHintsRepeatEmail(),
            action: TextInputAction.done,
            keyboardType: TextInputType.emailAddress
          )
        )
      ],
    );
  }

  @override
  GlobalKey<FormState> getFormKey(BuildContext context) {
    return Provider.of<AccountInfoFormKey>(context, listen: false).formKey;
  }

  @override
  void negativeButtonAction(BuildContext context) {
    final loginNavigation = Provider.of<LoginNavigationBloc>(context, listen: false);
    loginNavigation.goBack();
  }
}
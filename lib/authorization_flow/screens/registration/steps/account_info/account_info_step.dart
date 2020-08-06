import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/show_repeat_email_notifier.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step.dart';
import 'package:provider/provider.dart';

class AccountInfoStep extends BaseRegistrationFormStep {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  GlobalKey<FormState> get formKey => _formKey;
  
  @override
  Widget buildFormBody(BuildContext context) {
    final localization = Provider.of<AppLocalizations>(context);
    final bloc = Provider.of<AccountInfoStepBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        generateFormField(
          context,
          bloc.login,
          () {},
          (login) => bloc.setLogin(login),
          (login) => getBaseValidator(localization, login),
          localization.getText().loginHintsLogin(),
          TextInputAction.next
        ),
        generateFormField(
          context,
          bloc.email,
          () {},
          (email) => bloc.setEmail(email),
          (email) => getBaseValidator(localization, email),
          localization.getText().loginHintsEmail(),
          TextInputAction.next
        ),
        Consumer<ShowRepeatEmailNotifier>(
          builder: (context, animationNotifier, child) => AnimatedOpacity(
            opacity: animationNotifier.showRepeatEmail ? 1 : 0,
            curve: Curves.bounceOut,
            duration: Duration(milliseconds: 750),
            child: AnimatedContainer(
              height: animationNotifier.showRepeatEmail ? 100 : 0,
              duration: Duration(milliseconds: 150),
              child: child,
            ),
          ),
          child: generateFormField(
            context,
            bloc.repeatEmail,
            () {},
            (repeatEmail) => bloc.setRepeatEmail(repeatEmail),
            (repeatEmail) => getBaseValidator(localization, repeatEmail, customValidator: (value) {
              if (value != bloc.email) return localization.getText().loginValidateEmailsDontMatch();

              return null;
            }),
            localization.getText().loginHintsRepeatEmail(),
            TextInputAction.next
          )
        )
      ],
    );
  }

}
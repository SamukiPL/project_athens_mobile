import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/agreement/agreement_widget.dart';
import 'package:project_athens/athens_core/presentation/agreement/agreement_widget_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_form_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_form_key.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/show_repeat_password_notifier.dart';
import 'package:provider/provider.dart';

class RegistrationEndStep extends BaseRegistrationFormStep<RegistrationEndStepBloc> {

  RegistrationEndStep(bool fieldsEnabled) : super(fieldsEnabled);

  @override
  Widget buildFormBody(BuildContext context, RegistrationEndStepBloc bloc) {
    final localization = Provider.of<AppLocalizations>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        generateFormField(
          context: context,
          initialValue: bloc.firstName,
          callback: () {},
          onChanged: (firstName) => bloc.setFirstName(firstName),
          validator: (firstName) => getBaseValidator(localization, firstName),
          labelText: localization.getText().loginHintsFirstName()
        ),
        generateFormField(
          context: context,
          initialValue: bloc.lastName,
          callback: () {},
          onChanged: (lastName) => bloc.setLastName(lastName),
          validator: (lastName) => getBaseValidator(localization, lastName),
          labelText: localization.getText().loginHintsLastName()
        ),
        generateFormField(
          context: context,
          initialValue: bloc.password,
          callback: () {},
          onChanged: (password) => bloc.setPassword(password),
          validator: (password) => getBaseValidator(localization, password),
          labelText: localization.getText().loginHintsPassword(),
          obscureText: true
        ),
        Consumer<ShowRepeatPasswordNotifier>(
            builder: (context, animationNotifier, child) => AnimatedOpacity(
              opacity: animationNotifier.showRepeatPassword ? 1 : 0,
              curve: Curves.bounceOut,
              duration: Duration(milliseconds: 750),
              child: AnimatedContainer(
                height: animationNotifier.showRepeatPassword ? 100 : 0,
                duration: Duration(milliseconds: 150),
                child: child,
              ),
            ),
            child: generateFormField(
              context: context,
              initialValue: bloc.repeatPassword,
              callback: () { bloc.invokeAction(StepAction.POSITIVE); },
              onChanged: (repeatPassword) => bloc.setRepeatPassword(repeatPassword),
              validator: (repeatPassword) => getBaseValidator(localization, repeatPassword, customValidator: (value) {
                if (value != bloc.password) return localization.getText().loginValidateEmailsDontMatch();

                return null;
              }),
              labelText: localization.getText().loginHintsRepeatPassword(),
              action: TextInputAction.done,
              obscureText: true
            )
        )
      ],
    );
  }

  @override
  GlobalKey<FormState> getFormKey(BuildContext context) {
    return Provider.of<RegistrationEndFormKey>(context, listen: false).formKey;
  }
}
// @dart=2.9

import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step_bloc.dart';
import 'package:provider/provider.dart';

abstract class BaseRegistrationFormStep<BLOC extends BaseRegistrationStepBloc> extends BaseRegistrationStep<BLOC> {

  final bool fieldsEnabled;

  BaseRegistrationFormStep(this.fieldsEnabled);

  @override
  Widget buildStepBody(BuildContext context, BLOC bloc) {
    return Form(
        key: getFormKey(context),
        child: buildFormBody(context, bloc)
    );
  }

  @override
  void positiveButtonAction(BuildContext context, BLOC bloc) {
    if (!getFormKey(context).currentState.validate())
      return;

    bloc();
  }

  Widget buildFormBody(BuildContext context, BLOC bloc);

  GlobalKey<FormState> getFormKey(BuildContext context);

  @protected
  Widget generateFormField(
      {BuildContext context,
      String initialValue,
      VoidCallback callback,
      ValueChanged<String> onChanged,
      FormFieldValidator<String> validator,
      String labelText,
      TextInputAction action = TextInputAction.next,
      TextInputType keyboardType = TextInputType.name,
      bool obscureText = false}) =>
      Container(
        margin: EdgeInsets.fromLTRB(32, 8, 32, 16),
        child: TextFormField(
          initialValue: initialValue,
          onFieldSubmitted: (_) => (action == TextInputAction.next) ? {} : callback(),
          onChanged: onChanged,
          textInputAction: action,
          decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
          maxLines: 1,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          enabled: fieldsEnabled,
        ),
      );

  @protected
  String getBaseValidator(AppLocalizations localization, String value, {String Function(String) customValidator}) {
    if (value.isEmpty) return localization.getText().loginValidateFieldCannotBeEmpty();

    return customValidator != null ? customValidator(value) : null;
  }

}
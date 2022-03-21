import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step_bloc.dart';

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
    if (!getFormKey(context).currentState!.validate()) {
      bloc.resetFooterButtons();
      return;
    }

    bloc();
  }

  Widget buildFormBody(BuildContext context, BLOC bloc);

  GlobalKey<FormState> getFormKey(BuildContext context);

  @protected
  Widget generateFormField(
      {required BuildContext context,
      required String initialValue,
      required VoidCallback callback,
      required ValueChanged<String> onChanged,
      required FormFieldValidator<String> validator,
      required String labelText,
      TextInputAction action = TextInputAction.next,
      TextInputType keyboardType = TextInputType.name,
      bool obscureText = false,
      bool isCheckbox = false,
      List<FilteringTextInputFormatter>? inputFormatters
      }) =>
      Container(
        margin: EdgeInsets.fromLTRB(32, 8, 32, 16),
        child: TextFormField(
          inputFormatters: inputFormatters,
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
  Widget generateCheckboxField(
      {required BuildContext context,
        required bool initialValue,
        required VoidCallback callback,
        required ValueChanged<bool> onChanged,
        required FormFieldValidator<bool> validator,
        required Widget labelText,
        TextInputAction action = TextInputAction.next,
        TextInputType keyboardType = TextInputType.name,
        bool obscureText = false,
        bool isCheckbox = false
      }) =>
      Container(
        margin: EdgeInsets.fromLTRB(32, 0, 32, 8),
        child: CheckboxFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          validator: validator,
          enabled: fieldsEnabled,
          title: labelText,
        ),
      );

  @protected
  String? getBaseValidator(AppLocalizations localization, String? value, {String? Function(String?)? customValidator}) {
    if (value == null || value.isEmpty) return localization.getText().loginValidateFieldCannotBeEmpty();

    return customValidator != null ? customValidator(value) : null;
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      { required Widget title,
        FormFieldSetter<bool>? onSaved,
        FormFieldValidator<bool>? validator,
        bool initialValue = false,
        bool autovalidate = false,
        bool enabled = false,
        required ValueChanged<bool> onChanged,
      })
      : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      enabled: enabled,

      builder: (FormFieldState<bool> state) {
        return CheckboxListTile(
          contentPadding: EdgeInsets.zero,

          dense: state.hasError,
          title: title,
          value: state.value,
          onChanged: (bool? newValue) {
            onChanged(newValue == true);
            state.didChange(newValue);
          },
          subtitle: state.hasError
              ? Builder(
            builder: (BuildContext context) =>  Text(
              state.errorText ?? "",
              style: TextStyle(color: Theme.of(context).errorColor),
            ),
          )
              : null,
          controlAffinity: ListTileControlAffinity.leading,
        );
      });
}

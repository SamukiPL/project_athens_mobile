import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';

abstract class BaseRegistrationStep extends StatelessWidget {}

abstract class BaseRegistrationFormStep extends BaseRegistrationStep {

  GlobalKey<FormState> get formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
        child: buildFormBody(context)
    );
  }

  Widget buildFormBody(BuildContext context);

  @protected
  Widget generateFormField(
      BuildContext context,
      String initialValue,
      VoidCallback callback,
      ValueChanged<String> onChanged,
      FormFieldValidator<String> validator,
      String labelText,
      TextInputAction action) =>
      Container(
        margin: EdgeInsets.fromLTRB(32, 8, 32, 16),
        child: TextFormField(
          initialValue: initialValue,
          onFieldSubmitted: (_) => (action == TextInputAction.next) ? FocusScope.of(context).nextFocus() : callback(),
          onChanged: onChanged,
          textInputAction: action,
          decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )),
          maxLines: 1,
          validator: validator,
        ),
      );

  @protected
  String getBaseValidator(AppLocalizations localization, String value, {String Function(String) customValidator}) {
    if (value.isEmpty) return localization.getText().loginValidateFieldCannotBeEmpty();

    return customValidator != null ? customValidator(value) : null;
  }

}
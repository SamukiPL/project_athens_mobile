import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/show_repeat_password_notifier.dart';
import 'package:provider/provider.dart';

class RegistrationEndStep extends BaseRegistrationFormStep {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;
  
  @override
  Widget buildFormBody(BuildContext context) {
    final localization = Provider.of<AppLocalizations>(context);
    final bloc = Provider.of<RegistrationEndStepBloc>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        generateFormField(
            context,
            bloc.firstName,
            () {},
            (firstName) => bloc.setFirstName(firstName),
            (firstName) => getBaseValidator(localization, firstName),
            localization.getText().loginHintsFirstName(),
            TextInputAction.next
        ),
        generateFormField(
            context,
            bloc.lastName,
            () {},
            (lastName) => bloc.setLastName(lastName),
            (lastName) => getBaseValidator(localization, lastName),
            localization.getText().loginHintsLastName(),
            TextInputAction.next
        ),
        generateFormField(
            context,
            bloc.password,
            () {},
            (password) => bloc.setPassword(password),
            (password) => getBaseValidator(localization, password),
            localization.getText().loginHintsPassword(),
            TextInputAction.next
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
                context,
                bloc.repeatPassword,
                () {},
                (repeatPassword) => bloc.setRepeatPassword(repeatPassword),
                (repeatPassword) => getBaseValidator(localization, repeatPassword, customValidator: (value) {
                  if (value != bloc.password) return localization.getText().loginValidateEmailsDontMatch();

                  return null;
                }),
                localization.getText().loginHintsRepeatPassword(),
                TextInputAction.next
            )
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/authorization_flow/injections/registration_module.dart';
import 'package:project_athens/authorization_flow/navigation/login_navigation_bloc.dart';
import 'package:project_athens/authorization_flow/screens/base_login_screen.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_footer.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_header.dart';
import 'package:project_athens/authorization_flow/screens/registration/registration_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends BaseLoginScreen<RegistrationBloc> {
  @override
  Widget generateAppBar(BuildContext context, RegistrationBloc bloc) {
    return null;
  }

  @override
  Widget generateBody(BuildContext context, RegistrationBloc bloc) {
    var localization = Provider.of<AppLocalizations>(context);

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            RegistrationStepperHeader(localization),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 16),
                color: Colors.white,
                child: AccountInfoStep(),
              ),
            ),
            RegistrationStepperFooter(
                () { bloc.setStep(RegistrationStep.PASSWORD_AND_PERSONAL_INFO); },
                () { bloc.setStep(RegistrationStep.ACCOUNT_INFO); },
            )
          ],
        ),
      ),
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
  void onNetworkFailure(RegistrationBloc bloc) {
    bloc();
  }

  @override
  void onAuthFailure() {
    throw Exception("Should never occur on registration!");
  }

  @override
  void onSuccess(BuildContext context) {
    var loginNavigation =
        Provider.of<LoginNavigationBloc>(context, listen: false);
    loginNavigation.setItem(LoginDestination.REGISTER_DEPUTIES);
  }

//
//  Step _generateSecondStep(BuildContext context, RegistrationBloc bloc, AppLocalizations localization) => Step(
//    title: Text("Second Second Second"),
//    state: StepState.editing,
//    isActive: true,
//    content: Column(
//      children: <Widget>[
//        _generateFormField(
//          context,
//          bloc,
//          (login) => bloc.setFirstName(login),
//          localization.getText().loginHintsFirstName(),
//          TextInputAction.next
//      ),
//        _generateFormField(
//            context,
//            bloc,
//                (login) => bloc.setLastName(login),
//            localization.getText().loginHintsLastName(),
//            TextInputAction.next
//        ),
//      ],
//    ),
//  );
//
//  Step _generateThirdStep(BuildContext context, RegistrationBloc bloc, AppLocalizations localization) => Step(
//    title: Text("Third Third Third"),
//    content: Column(
//      children: <Widget>[
//        _generateFormField(
//            context,
//            bloc,
//            (login) => bloc.setPassword(login),
//            localization.getText().loginHintsPassword(),
//            TextInputAction.next
//        ),
//        _generateFormField(
//            context,
//            bloc,
//            (login) => bloc.setRepeatPassword(login),
//            localization.getText().loginHintsRepeatPassword(),
//            TextInputAction.done
//        ),
//        RaisedButton(
//          child: Container(
//            padding: EdgeInsets.all(16),
//            child: Text(
//              localization.getText().loginButtonsRegister(),
//              style: TextStyle(color: Colors.white),
//              textScaleFactor: 1.5,
//            ),
//          ),
//          onPressed: () => bloc(),
//          color: Theme.of(context).primaryColor,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(32),
//          ),
//        ),
//      ],
//    ),
//  );

}

import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/app_navigation.dart';
import 'package:project_athens/authorization_flow/injections/deputies_registration_module.dart';
import 'package:project_athens/authorization_flow/injections/registration_module.dart';
import 'package:project_athens/authorization_flow/screens/base_login_screen.dart';
import 'package:project_athens/authorization_flow/screens/registration/registration_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_footer.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_header.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/deputies_chooser_step.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_step.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends BaseLoginScreen<RegistrationBloc> {

  @override
  List<Module> getProviders(BuildContext context) {
    return [RegistrationModule(context), DeputiesRegistrationModule(context)];
  }

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
        child: IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RegistrationStepperHeader(localization),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      AccountInfoStep(),
                      Consumer<RegistrationStepperBloc>(
                        child: Container(
                          color: Colors.white,
                          child: RegistrationEndStep()
                        ),
                        builder: (context, stepperBloc, child) => AnimatedContainer(
                          duration: Duration(milliseconds: 267),
                          transform: Matrix4.translationValues(
                            stepperBloc.currentStep.index < 1 ? MediaQuery.of(context).size.width : 0,
                            0, 0
                          ),
                          child: child,
                        ),
                      ),
                      Consumer<RegistrationStepperBloc>(
                        builder: (context, stepperBloc, _) => AnimatedContainer(
                          duration: Duration(milliseconds: 267),
                          transform: Matrix4.translationValues(
                            stepperBloc.currentStep.index < 2 ? MediaQuery.of(context).size.width : 0,
                            0, 0
                          ),
                          child: Container(
                            color: Colors.white,
                            child: DeputiesChooserStep()
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RegistrationStepperFooter(
                  () { bloc.positiveButtonAction(); },
                  () { bloc.negativeButtonAction(); },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget generateFab(BuildContext context, RegistrationBloc bloc) {
    return null;
  }

  @override
  void onNetworkFailure(RegistrationBloc bloc) {
  }

  @override
  void onAuthFailure() {
    throw Exception("Should never occur on registration!");
  }

  @override
  void onSuccess(BuildContext context) {
    var appNavigation = Provider.of<AppNavigation>(context, listen: false);
    appNavigation.goToMainWidget(context);
  }

}

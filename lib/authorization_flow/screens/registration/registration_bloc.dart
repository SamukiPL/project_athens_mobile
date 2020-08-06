import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';

class RegistrationBloc extends BaseBloc {
  final RegistrationStepperBloc _stepperBloc;

  final AccountInfoStepBloc _accountInfoStepBloc;

  final RegistrationEndStepBloc _registrationEndStepBloc;

  RegistrationBloc(this._stepperBloc, this._accountInfoStepBloc, this._registrationEndStepBloc);

  void positiveButtonAction() {
    switch(_stepperBloc.currentStep) {
      case RegistrationStep.ACCOUNT_INFO:
        // TODO: Handle this case.
        break;
      case RegistrationStep.REGISTRATION_END:
        // TODO: Handle this case.
        break;
      case RegistrationStep.DEPUTIES_CHOOSER:
        // TODO: Handle this case.
        break;
    }
  }

  void negativeButtonAction() {
    switch(_stepperBloc.currentStep) {
      case RegistrationStep.ACCOUNT_INFO:
      // TODO: Handle this case.
        break;
      case RegistrationStep.REGISTRATION_END:
      // TODO: Handle this case.
        break;
      case RegistrationStep.DEPUTIES_CHOOSER:
      // TODO: Handle this case.
        break;
    }
  }

  @override
  void dispose() {
    _stepperBloc.dispose();
    _accountInfoStepBloc.dispose();
    _registrationEndStepBloc.dispose();
    super.dispose();
  }
}

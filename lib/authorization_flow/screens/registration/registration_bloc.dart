import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/stepper_button_state_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/deputies_chooser_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/registration_end_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';

class RegistrationBloc extends BaseBloc {
  final RegistrationStepperBloc _stepperBloc;
  
  final StepperButtonStateBloc _buttonStateBloc;

  final AccountInfoStepBloc _accountInfoStepBloc;

  final RegistrationEndStepBloc _registrationEndStepBloc;

  final DeputiesChooserBloc _deputiesChooserBloc;

  RegistrationBloc(
      this._stepperBloc, 
      this._buttonStateBloc, 
      this._accountInfoStepBloc, 
      this._registrationEndStepBloc,
      this._deputiesChooserBloc
  ) {
    _listenToAccountInfoBloc();
    _listenToRegistrationEndStepBLoc();
    _listenToDeputiesChooserBloc();
  }

  void _listenToAccountInfoBloc() {
    _accountInfoStepBloc.state.listen((screenState) {
      switch (screenState.runtimeType) {
        case SuccessState:
          _buttonStateBloc.changeState(StepperButtonState.IDLE);
          _registrationEndStepBloc.setLoginAndEmail(
              _accountInfoStepBloc.login, _accountInfoStepBloc.email);
          _stepperBloc.setStep(RegistrationStep.REGISTRATION_END);
          break;
        case ErrorState:
          _buttonStateBloc.changeState(StepperButtonState.IDLE);
          break;
        default:
          stateController.add(screenState);
      }
    });
    _accountInfoStepBloc.headingLine.listen((event) {
      _stepperBloc.setHeaderHelperLine(event);
    });
    _accountInfoStepBloc.resetFooterButtonState.listen((event) {
      _buttonStateBloc.changeState(StepperButtonState.IDLE);
    });
  }

  void _listenToRegistrationEndStepBLoc() {
    _registrationEndStepBloc.state.listen((screenState) {
      switch (screenState.runtimeType) {
        case SuccessState:
          _buttonStateBloc.changeState(StepperButtonState.IDLE);
          _stepperBloc.setStep(RegistrationStep.DEPUTIES_CHOOSER);
          break;
        default:
          stateController.add(screenState);
      }
    });
    _registrationEndStepBloc.headingLine.listen((event) {
      _stepperBloc.setHeaderHelperLine(event);
    });

  }
  
  void _listenToDeputiesChooserBloc() {
    _deputiesChooserBloc.state.listen((screenState) {
      _buttonStateBloc.changeState(StepperButtonState.IDLE);
      stateController.add(screenState);
    });
    _deputiesChooserBloc.headingLine.listen((event) {
      _stepperBloc.setHeaderHelperLine(event);
    });
  }

  void positiveButtonAction() {
    _buttonStateBloc.changeState(StepperButtonState.LOADING);
    switch(_stepperBloc.currentStep) {
      case RegistrationStep.ACCOUNT_INFO:
        _accountInfoStepBloc.invokeAction(StepAction.POSITIVE);
        break;
      case RegistrationStep.REGISTRATION_END:
        _registrationEndStepBloc.invokeAction(StepAction.POSITIVE);
        break;
      case RegistrationStep.DEPUTIES_CHOOSER:
        _deputiesChooserBloc.invokeAction(StepAction.POSITIVE);
        break;
    }
  }

  void negativeButtonAction() {
    switch(_stepperBloc.currentStep) {
      case RegistrationStep.ACCOUNT_INFO:
        _accountInfoStepBloc.invokeAction(StepAction.NEGATIVE);
        break;
      case RegistrationStep.REGISTRATION_END:
        _stepperBloc.setStep(RegistrationStep.ACCOUNT_INFO);
        break;
      case RegistrationStep.DEPUTIES_CHOOSER:
        _deputiesChooserBloc.invokeAction(StepAction.NEGATIVE);
        break;
    }
  }

  void headerIconAction() {
    if (_stepperBloc.currentStep == RegistrationStep.DEPUTIES_CHOOSER) {
      _deputiesChooserBloc.showSearchBar();
    }
  }

  @override
  void dispose() {
    _stepperBloc.dispose();
    _accountInfoStepBloc.dispose();
    _registrationEndStepBloc.dispose();
    _deputiesChooserBloc.dispose();
    super.dispose();
  }
}

import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/stepper/registration_stepper_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/account_info_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_steps.dart';

class RegistrationBloc extends BaseBloc {
  final RegistrationStepperBloc _headerBloc;

  final AccountInfoStepBloc _accountInfoStepBloc;

  RegistrationBloc(this._headerBloc, this._accountInfoStepBloc);

  String _firstName = "";
  String _lastName = "";
  String _login = "";
  String _email = "";
  String _repeatEmail = "";
  String _password = "";
  String _repeatPassword = "";

  void setFirstName(String firstName) {
    _firstName = firstName;
  }

  void setLastName(String lastName) {
    _lastName = lastName;
  }

  void setLogin(String login) {
    _login = login;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setRepeatEmail(String repeatEmail) {
    _repeatEmail = repeatEmail;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setRepeatPassword(String repeatPassword) {
    _repeatPassword = repeatPassword;
  }

  void setStep(RegistrationStep step) {
    _headerBloc.setStep(step);
  }

  Future<void> call() async {
//    if ((_firstName.isEmpty ||
//            _lastName.isEmpty ||
//            _login.isEmpty ||
//            _email.isEmpty ||
//            _password.isEmpty ||
//            _repeatPassword.isEmpty) &&
//        _password == _repeatPassword) return;
//
//    final params = RegistrationParams(_firstName, _lastName, _login, _email, _password, List<String>());
//
//    final result = await _registrationUseCase(params);
//    manageState(result);
  }
}

import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_use_case.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/show_repeat_password_notifier.dart';

class RegistrationEndStepBloc extends BaseBloc {

  final RegistrationUseCase _registrationUseCase;

  final ShowRepeatPasswordNotifier _animationNotifier;

  RegistrationEndStepBloc(this._registrationUseCase, this._animationNotifier);

  String _login = "";
  String _email = "";

  String _firstName = "";
  String _lastName = "";
  String _password = "";
  String _repeatPassword = "";

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get password => _password;
  String get repeatPassword => _repeatPassword;

  void setLoginAndEmail(String login, String email) {
    _login = login;
    _email = email;
  }

  void setFirstName(String firstName) {
    _firstName = firstName;
  }

  void setLastName(String lastName) {
    _lastName = lastName;
  }

  void setPassword(String password) {
    _password = password;
    _animationNotifier.manageAnimation(password.isNotEmpty);
  }

  void setRepeatPassword(String repeatPassword) {
    _repeatPassword = repeatPassword;
  }

  Future<void> call() async {

  }

}
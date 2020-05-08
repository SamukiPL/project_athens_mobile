import 'package:athens_core/presentation/base_bloc.dart';
import 'package:authorization_flow/domain/registration/registration_params.dart';
import 'package:authorization_flow/domain/registration/registration_use_case.dart';

class RegistrationBloc extends BaseBloc {
  final RegistrationUseCase _registrationUseCase;

  RegistrationBloc(this._registrationUseCase);

  String _firstName = "";
  String _lastName = "";
  String _login = "";
  String _email = "";
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

  void setPassword(String password) {
    _password = password;
  }

  void setRepeatPassword(String repeatPassword) {
    _repeatPassword = repeatPassword;
  }

  Future<void> call() async {
    if ((_firstName.isEmpty ||
            _lastName.isEmpty ||
            _login.isEmpty ||
            _email.isEmpty ||
            _password.isEmpty ||
            _repeatPassword.isEmpty) &&
        _password == _repeatPassword) return;

    final params = RegistrationParams(_firstName, _lastName, _login, _email, _password, List<String>());

    final result = await _registrationUseCase(params);
    manageState(result);
  }
}

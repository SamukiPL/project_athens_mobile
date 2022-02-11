import 'package:project_athens/athens_core/configuration/configuration_delegate.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_params.dart';
import 'package:project_athens/authorization_flow/domain/registration/registration_use_case.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step_bloc.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/registration_end/show_repeat_password_notifier.dart';

class RegistrationEndStepBloc extends BaseRegistrationStepBloc with ConfigurationDelegate<DateTime, DateTime> {

  final RegistrationUseCase _registrationUseCase;
  final int _currentCadence;

  final ShowRepeatPasswordNotifier _animationNotifier;

  RegistrationEndStepBloc(this._registrationUseCase, this._animationNotifier, this._currentCadence);

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


  @override
  DateTime? get defaultStorageValue => null;

  @override
  String get preferenceName => ConfigurationStorageNames.LAST_PRIVACY_POLICY_VERSION;

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
    final params = RegistrationParams(_firstName, _lastName, _login, _email, _password, List<String>.empty(), _currentCadence);

    final result = await _registrationUseCase(params);

    await updatePreference(DateTime.now());

    manageState(result);
  }


}
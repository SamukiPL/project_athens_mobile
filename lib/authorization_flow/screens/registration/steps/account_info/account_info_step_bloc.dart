import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_model.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_params.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_use_case.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/show_repeat_email_notifier.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/base_registration_step_bloc.dart';

class AccountInfoStepBloc extends BaseRegistrationStepBloc {

  final CheckPairUsageUseCase _checkPairUsageUseCase;

  final ShowRepeatEmailNotifier _animationNotifier;

  AccountInfoStepBloc(this._checkPairUsageUseCase, this._animationNotifier);

  String _login = "";
  String _email = "";
  String _repeatEmail = "";

  bool _loginTaken = false;
  bool _emailTaken = false;

  String get login => _login;
  String get email => _email;
  String get repeatEmail => _repeatEmail;

  bool get loginTaken => _loginTaken;
  bool get emailTaken => _emailTaken;

  void setLogin(String login) {
    _login = login;
    _loginTaken = false;
  }

  void setEmail(String email) {
    _email = email;
    _emailTaken = false;
    _animationNotifier.manageAnimation(email.isNotEmpty);
  }

  void setRepeatEmail(String repeatEmail) {
    _repeatEmail = repeatEmail;
  }

  @override
  Future<void> call() async {
    final result = await _checkPairUsageUseCase.call(CheckPairUsageParams(_login, _email)).safeApiCall();
    if (result is Success<CheckPairUsageModel> &&
        result.result.isSomethingTaken) {
      _loginTaken = result.result.loginTaken;
      _emailTaken = result.result.emailTaken;
      invokeAction(StepAction.POSITIVE);
      return;
    }

    manageState(result);
  }

}
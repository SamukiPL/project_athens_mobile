import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_params.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_use_case.dart';
import 'package:project_athens/authorization_flow/screens/registration/steps/account_info/show_repeat_email_notifier.dart';

class AccountInfoStepBloc extends BaseBloc {

  final CheckPairUsageUseCase _checkPairUsageUseCase;

  final ShowRepeatEmailNotifier _animationNotifier;

  AccountInfoStepBloc(this._checkPairUsageUseCase, this._animationNotifier);

  String _login = "";
  String _email = "";
  String _repeatEmail = "";

  String get login => _login;
  String get email => _email;
  String get repeatEmail => _repeatEmail;

  void setLogin(String login) {
    _login = login;
  }

  void setEmail(String email) {
    _email = email;
    _animationNotifier.manageAnimation(email.isNotEmpty);
  }

  void setRepeatEmail(String repeatEmail) {
    _repeatEmail = repeatEmail;
  }

  Future<void> call() async {
    final result = await _checkPairUsageUseCase.call(CheckPairUsageParams(_login, _email)).safeApiCall();
    manageState(result);
  }

}
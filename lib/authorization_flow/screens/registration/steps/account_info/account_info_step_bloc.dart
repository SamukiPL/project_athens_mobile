import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_change_notifier.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_params.dart';
import 'package:project_athens/authorization_flow/domain/registration/check_pair_usage_use_case.dart';

class AccountInfoStepBloc extends BaseChangeNotifier {

  final CheckPairUsageUseCase _checkPairUsageUseCase;

  AccountInfoStepBloc(this._checkPairUsageUseCase);

  String _login = "";
  String _email = "";
  String _repeatEmail = "";

  String get email => _email;

  bool _showRepeatEmail = false;

  bool get showRepeatEmail => _showRepeatEmail;

  void setLogin(String login) {
    _login = login;
  }

  void setEmail(String email) {
    _email = email;

    final newValue = email.isNotEmpty;
    if (newValue != _showRepeatEmail) {
      _showRepeatEmail = newValue;
      notifyListeners();
    }
  }

  void setRepeatEmail(String repeatEmail) {
    _repeatEmail = repeatEmail;
  }

  Future<void> call() async {
    if (_login.isEmpty || _email.isEmpty || _repeatEmail.isEmpty)
      return;

    _checkPairUsageUseCase.call(CheckPairUsageParams(_login, _email));
  }

}
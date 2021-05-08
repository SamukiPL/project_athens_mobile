import 'dart:async';

import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/authorization_flow/domain/login/login_params.dart';
import 'package:project_athens/authorization_flow/domain/login/login_use_case.dart';
import 'package:project_athens/authorization_flow/screens/login/auth_failed_notifier.dart';
import 'package:project_athens/deputies_utils/domain/base_deputies_params.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_use_case.dart';

class LoginBloc extends BaseBloc {

  final LoginUseCase _loginUseCase;

  final FirebaseDeputiesUseCase _firebaseDeputiesUseCase;

  final _cadency = 9;
  final AuthFailedNotifier authFailedNotifier = AuthFailedNotifier();

  LoginBloc(this._loginUseCase, this._firebaseDeputiesUseCase);

  String _login = "";

  String _password = "";

  void setLogin(String login) {
    _login = login;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setAuthFailed(bool hasFailed) {
    authFailedNotifier.state = hasFailed;
  }

  Future<void> call() async {
    if (_login.isEmpty || _password.isEmpty) return;

    authFailedNotifier.state = false;

    var params = LoginParams(_login, _password);

    var loginResult = await _loginUseCase(params);

    if (loginResult is Success) {
      final deputiesParams = BaseDeputiesParams(_cadency);
      var subscribeResult = await _firebaseDeputiesUseCase(deputiesParams);

      return manageState(subscribeResult);
    }

    manageState(loginResult);
  }


}
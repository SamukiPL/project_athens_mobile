import 'dart:async';

import 'package:athens_core/domain/base_repository.dart';
import 'package:athens_core/presentation/base_bloc.dart';
import 'package:authorization_flow/domain/login/login_params.dart';
import 'package:authorization_flow/domain/login/login_use_case.dart';

class LoginBloc extends BaseBloc {

  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase);

  String _login = "";

  String _password = "";

  void setLogin(String login) {
    _login = login;
  }

  void setPassword(String password) {
    _password = password;
  }

  Future<void> call() async {
    if (_login.isEmpty || _password.isEmpty) return;

    var params = LoginParams(_login, _password);

    var result = await _loginUseCase(params).safeApiCall();
    manageState(result);
  }


}
import 'dart:async';

import 'package:athens_core/presentation/base_bloc.dart';
import 'package:authorization_flow/domain/login/login_params.dart';
import 'package:authorization_flow/domain/login/login_response.dart';
import 'package:authorization_flow/domain/login/login_use_case.dart';

enum LoginScreenState { SUCCESS, AUTH_FAILURE, NETWORK_FAILURE }

class LoginBloc extends BaseBloc {

  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase);

  StreamController<LoginScreenState> _state = StreamController<LoginScreenState>();

  String _login = "";

  String _password = "";

  void setLogin(String login) {
    _login = login;
  }

  void setPassword(String password) {
    _password = password;
  }

  Future<void> logIn() async {
    if (_login.isEmpty || _password.isEmpty) return;

    var params = LoginParams(_login, _password);

    var status = await loginUseCase(params);
    switch(status) {
      case LoginStatus.SUCCESS:
        _state.add(LoginScreenState.SUCCESS);
        break;
      case LoginStatus.AUTH_FAILURE:
        _state.add(LoginScreenState.AUTH_FAILURE);
        break;
      case LoginStatus.NETWORK_FAILURE:
        _state.add(LoginScreenState.NETWORK_FAILURE);
        break;
    }
  }

  @override
  void dispose() {
    _state.close();
  }

}
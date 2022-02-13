import 'dart:async';

import 'package:project_athens/athens_core/configuration/configuration_delegate.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:project_athens/authorization_flow/domain/login/login_params.dart';
import 'package:project_athens/authorization_flow/domain/login/login_use_case.dart';
import 'package:project_athens/authorization_flow/screens/login/auth_failed_notifier.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_use_case.dart';

class LoginBloc extends BaseBloc with ConfigurationDelegate {

  final LoginUseCase _loginUseCase;

  final FirebaseDeputiesUseCase _firebaseDeputiesUseCase;

  final RemoteConfiguration _remoteConfiguration;

  final AuthFailedNotifier authFailedNotifier = AuthFailedNotifier();
  final DataLoadingBloc loginButtonLoadingBloc = DataLoadingBloc();

  LoginBloc(this._loginUseCase, this._firebaseDeputiesUseCase, this._remoteConfiguration) {
    _initSavedLoginOrEmail();
  }

  String _login = "";

  String _password = "";

  String get login => _login;

  @override
  get defaultStorageValue => "";

  @override
  String get preferenceName => ConfigurationStorageNames.LOGIN_OR_EMAIL;

  void _initSavedLoginOrEmail() async {
    final String? loginOrEmail = await fetchPreference((json) => null);

    setLogin(loginOrEmail ?? "");
  }

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
    loginButtonLoadingBloc.setDataLoadingState(DataLoadingState.loading());

    final LoginParams params = _login.contains('@')
        ? LoginParams(password: _password, email: _login, cadence: _remoteConfiguration.cadence)
        : LoginParams(password: _password, login: _login, cadence: _remoteConfiguration.cadence);

    final loginResult = await _loginUseCase(params);

    if (loginResult is Success) {
      final subscribeResult = await _firebaseDeputiesUseCase();
      loginButtonLoadingBloc.setDataLoadingState(DataLoadingState.contentLoaded());

      return manageState(subscribeResult);
    } else {
      if (loginResult is Failure) {
        loginButtonLoadingBloc.setDataLoadingState(DataLoadingState.error(loginResult.exception.getErrorType()));
      } else {
        loginButtonLoadingBloc.setDataLoadingState(DataLoadingState.initialLoading());
      }
    }

    manageState(loginResult);
  }



}
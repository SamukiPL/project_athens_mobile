import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/configuration/configuration_delegate.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:project_athens/authorization_flow/domain/login/login_as_guest_use_case.dart';
import 'package:project_athens/authorization_flow/domain/login/login_params.dart';
import 'package:project_athens/authorization_flow/domain/login/login_use_case.dart';
import 'package:project_athens/authorization_flow/screens/login/auth_failed_notifier.dart';
import 'package:project_athens/authorization_flow/screens/login/login_type.dart';
import 'package:project_athens/deputies_utils/domain/firebase_deputies/firebase_deputies_use_case.dart';

class LoginBloc extends BaseBloc with ConfigurationDelegate<String?, String> {

  final LoginUseCase _loginUseCase;
  final LoginAsGuestUseCase _loginAsGuestUseCase;

  final FirebaseDeputiesUseCase _firebaseDeputiesUseCase;

  final RemoteConfiguration _remoteConfiguration;

  final AuthFailedNotifier authFailedNotifier = AuthFailedNotifier();
  final DataLoadingBloc loginButtonLoadingBloc = DataLoadingBloc();

  LoginBloc(this._loginUseCase, this._loginAsGuestUseCase, this._firebaseDeputiesUseCase,
      this._remoteConfiguration) {
    _initSavedLoginOrEmail();
  }

  GlobalKey<FormState> _loginScreenForm = GlobalKey<FormState>();

  String _login = "";

  String _password = "";

  TextEditingController _textEditingController = TextEditingController();

  String get login => _login;

  GlobalKey<FormState> get loginScreenForm => _loginScreenForm;

  TextEditingController get textEditingController => _textEditingController;

  @override
  get defaultStorageValue => "";

  @override
  String get preferenceName => ConfigurationStorageNames.LOGIN_OR_EMAIL;

  late LoginType _loginType;
  bool get wasLoggedNormally => _loginType is NormalLogin;

  void _initSavedLoginOrEmail() async {
    final String? loginOrEmail = await fetchPreference(null);
    setLogin(loginOrEmail ?? "");
    textEditingController.text = login;
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
    if (loginScreenForm.currentState?.validate() == false) return;

    authFailedNotifier.state = false;
    loginButtonLoadingBloc.setDataLoadingState(DataLoadingState.loading());

    final LoginParams params = _login.contains('@')
        ? LoginParams(password: _password, email: _login, cadence: _remoteConfiguration.cadence)
        : LoginParams(password: _password, login: _login, cadence: _remoteConfiguration.cadence);

    final loginResult = await _loginUseCase(params);

    if (loginResult is Success) {
      final subscribeResult = await _firebaseDeputiesUseCase();
      loginButtonLoadingBloc.setDataLoadingState(DataLoadingState.contentLoaded());
      await updatePreference(_login);
      _loginType = LoginType.normal();
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

  Future<void> loginAsGuest() async {
    if (!(loginButtonLoadingBloc.loadingState is InitialLoading)) return;
    loginButtonLoadingBloc.setDataLoadingState(DataLoadingState.loading());
    final loginResult = await _loginAsGuestUseCase();

    if (loginResult is Success) {
      loginButtonLoadingBloc.setDataLoadingState(DataLoadingState.contentLoaded());
      await updatePreference(_login);
      _loginType = LoginType.guest();
    } else {
      loginButtonLoadingBloc.setDataLoadingState(DataLoadingState.initialLoading());
    }
    return manageState(loginResult);
  }
}

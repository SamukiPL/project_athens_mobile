
import 'dart:async';
import 'dart:io';

import 'package:project_athens/athens_core/chopper/client_errors.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

enum ScreenState { SUCCESS, AUTH_FAILURE, NETWORK_FAILURE }

abstract class BaseBloc {

  StreamController<ScreenState> _stateController = BehaviorSubject<ScreenState>();

  Stream<ScreenState> get state => _stateController.stream;

  @protected
  void manageState(Result result) {
    if (result is Success) {
      _stateController.add(ScreenState.SUCCESS);
    } else if (result is Failure && result.exception is SocketException) {
      _stateController.add(ScreenState.NETWORK_FAILURE);
    } else if (result is Failure && result.exception is ClientError) {
      _stateController.add(ScreenState.AUTH_FAILURE);
    }
  }

  void dispose() {
    _stateController.close();
  }

}
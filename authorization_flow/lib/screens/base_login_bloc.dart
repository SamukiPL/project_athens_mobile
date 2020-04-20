import 'dart:async';
import 'dart:io';

import 'package:athens_core/chopper/client_errors.dart';
import 'package:athens_core/domain/result.dart';
import 'package:athens_core/presentation/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

enum ScreenState { SUCCESS, AUTH_FAILURE, NETWORK_FAILURE }

abstract class BaseLoginBloc extends BaseBloc {


  StreamController<ScreenState> _stateController = BehaviorSubject<ScreenState>();

  Stream<ScreenState> get state => _stateController.stream;

  void manageState(Result result) {
    if (result is Success) {
      _stateController.add(ScreenState.SUCCESS);
    } else if (result is Failure && result.exception is SocketException) {
      _stateController.add(ScreenState.NETWORK_FAILURE);
    } else if (result is Failure && result.exception is ClientError) {
      _stateController.add(ScreenState.AUTH_FAILURE);
    }
  }

  @override
  void dispose() {
    _stateController.close();
  }

}
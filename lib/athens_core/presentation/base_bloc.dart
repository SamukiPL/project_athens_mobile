
import 'dart:async';
import 'dart:io';

import 'package:project_athens/athens_core/chopper/client_errors.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:rxdart/rxdart.dart';

enum ScreenState { SUCCESS, AUTH_FAILURE, NETWORK_FAILURE }

abstract class BaseBloc {

  final DataLoadingBloc _dataLoadingBloc = DataLoadingBloc();

  DataLoadingBloc get dataLoadingBloc => _dataLoadingBloc;

  @protected
  StreamController<ScreenState> stateController = BehaviorSubject<ScreenState>();

  Stream<ScreenState> get state => stateController.stream;

  @protected
  void manageState(Result result) {
    if (result is Success) {
      stateController.add(ScreenState.SUCCESS);
    } else if (result is Failure && result.exception is SocketException) {
      stateController.add(ScreenState.NETWORK_FAILURE);
      setLoadingState(DataLoadingState.NO_NETWORK);
    } else if (result is Failure && result.exception is ClientError) {
      stateController.add(ScreenState.AUTH_FAILURE);
    }
  }

  @protected
  void setLoadingState(DataLoadingState dataLoadingState) {
    _dataLoadingBloc.setDataLoadingState(dataLoadingState);
  }

  void dispose() {
    stateController.close();
  }

}
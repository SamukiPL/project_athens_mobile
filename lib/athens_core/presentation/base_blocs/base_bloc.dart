
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {

  final DataLoadingBloc _dataLoadingBloc = DataLoadingBloc();
  final DataLoadingBloc _btnActionAwaitBloc = DataLoadingBloc();

  DataLoadingBloc get dataLoadingBloc => _dataLoadingBloc;
  DataLoadingBloc get btnActionAwaitBloc => _btnActionAwaitBloc;

  @protected
  StreamController<WidgetState> stateController = BehaviorSubject<WidgetState>();

  Stream<WidgetState> get state => stateController.stream;

  @protected
  void manageState(Result result) {
    if (result is Success) {
      _btnActionAwaitBloc.setDataLoadingState(DataLoadingState.contentLoaded());
      stateController.add(WidgetState.success());
    } else if (result is Failure) {
      Failure failure = result;
      final state = failure.exception.getWidgetState();
      final errorType = failure.exception.getErrorType();
      _btnActionAwaitBloc.setDataLoadingState(DataLoadingState.error(errorType));

      _manageErrorState(state);
      stateController.add(state);
    }
  }

  void _manageErrorState(WidgetState state) {
    if (state is ErrorState) {
      ErrorState errorState = state;
      setLoadingState(DataLoadingState.error(errorState.type));
    }
  }

  void goToDestination(Destination destination) {
    stateController.add(WidgetState.redirection(destination));
  }

  @protected
  void setLoadingState(DataLoadingState dataLoadingState) {
    _dataLoadingBloc.setDataLoadingState(dataLoadingState);
  }

  void dispose() {
    stateController.close();
  }

}
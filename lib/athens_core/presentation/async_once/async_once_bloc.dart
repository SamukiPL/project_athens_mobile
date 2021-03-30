import 'dart:async';

import 'package:project_athens/athens_core/domain/async_once/async_once_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:rxdart/rxdart.dart';

class AsyncOnceBloc<T> extends BaseChangeNotifier {
  final AsyncOnceUseCase<T> _asyncOnceUseCase;

  AsyncOnceBloc(this._asyncOnceUseCase) {
    asyncOnce();
  }

  final DataLoadingBloc _dataLoadingBloc = DataLoadingBloc();

  DataLoadingBloc get dataLoadingBloc => _dataLoadingBloc;

  T _value;

  T get value => _value;

  Future<void> asyncOnce() async {
    _dataLoadingBloc.setDataLoadingState(DataLoadingState.initialLoading());
    _asyncOnceUseCase().then((result) {
      if (result is Success<T>) {
        _value = result.value;
        final newState = (result.value != null)
            ? DataLoadingState.contentLoaded()
            : DataLoadingState.noData();
        _dataLoadingBloc.setDataLoadingState(newState);
      } else if (result is Failure<T>) {
        final errorType = result.exception.getErrorType();
        _dataLoadingBloc.setDataLoadingState(DataLoadingState.error(errorType));
      }
    });
    notifyListeners();
  }
}

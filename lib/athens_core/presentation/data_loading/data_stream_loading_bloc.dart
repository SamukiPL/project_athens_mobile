import 'dart:async';

import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';

class DataStreamLoadingBloc<T> extends DataLoadingBloc {
  DataStreamLoadingBloc(Stream<T> stream) {
    _streamSubscription = stream.listen((event) {
      if (event == null) {
        super.setDataLoadingState(DataLoadingState.initialLoading());
      }
    });
  }

  late StreamSubscription _streamSubscription;

  void dispose() {
    _streamSubscription.cancel();
  }
}
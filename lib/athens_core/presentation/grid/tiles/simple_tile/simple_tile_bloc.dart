import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:rxdart/rxdart.dart';

class SimpleTileBloc extends BaseBloc {
  @protected
  final BehaviorSubject<DataLoadingState> loadingStateSource =
    BehaviorSubject.seeded(DataLoadingState.noData());

  Stream<DataLoadingState> get loadingState => loadingStateSource.stream;
  DataLoadingState get currentLoadingState => loadingStateSource.value;

  @override
  void dispose() {
    super.dispose();

    loadingStateSource.close();
  }

  showLoader() {
    loadingStateSource.add(DataLoadingState.initialLoading());
  }

  hideLoader() {
    loadingStateSource.add(DataLoadingState.contentLoaded());
  }
}
import 'package:project_athens/athens_core/presentation/widget_state.dart';

abstract class DataLoadingState {
 DataLoadingState._();
 
 factory DataLoadingState.initialLoading() = InitialLoading;
 factory DataLoadingState.contentLoaded() = ContentLoaded;
 factory DataLoadingState.loading() = Loading;
 factory DataLoadingState.noData() = NoDataLoaded;
 factory DataLoadingState.error(ErrorType errorType) = LoadingError;
}

class InitialLoading extends DataLoadingState {
  InitialLoading() : super._();
}

class ContentLoaded extends DataLoadingState {
 ContentLoaded() : super._();
}

class Loading extends DataLoadingState {
 Loading() : super._();
}

class NoDataLoaded extends DataLoadingState {
 NoDataLoaded() : super._();
}

class LoadingError extends DataLoadingState {
 final ErrorType errorType;
 
 LoadingError(this.errorType) : super._();
}
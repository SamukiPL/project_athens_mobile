import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/no_data/no_data.dart';
import 'package:project_athens/athens_core/presentation/retry/retry_widget.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:provider/provider.dart';

class DataLoadingWidget extends StatelessWidget {

  final DataLoadingBloc _bloc;

  final Widget initialLoading;
  final Widget child;
  final Widget noData;
  final String noDataText;
  final Widget retryWidget;
  final VoidCallback onRetry;

  const DataLoadingWidget(
      this._bloc,
      {Key key,
      this.initialLoading,
      @required this.child,
      this.noData,
      this.noDataText,
      this.retryWidget,
      @required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataLoadingBloc>.value(
      value: _bloc,
      child: Consumer<DataLoadingBloc>(builder: (context, bloc, _) {
        switch (bloc.loadingState.runtimeType) {
          case InitialLoading:
            return _getInitialLoading();
            break;
          case ContentLoaded:
            return child;
            break;
          case NoDataLoaded:
            return _getNoData();
            break;
          case LoadingError:
            LoadingError loadingError = bloc.loadingState;
            return _getRetryWidget(loadingError.errorType);
            break;
          default:
            throw ArgumentError();
        }
      }),
    );
  }

  Widget _getInitialLoading() {
    return initialLoading ?? _buildBaseInitialLoading();
  }

  Widget _buildBaseInitialLoading() => Center(
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              widthFactor: 10,
              heightFactor: 10,
              child: CircularProgressIndicator(),
            )
          ],
        ),
  );

  Widget _getNoData() {
    return noData ?? _buildBaseNoData();
  }

  Widget _buildBaseNoData() => NoData(
        text: noDataText,
      );
  
  Widget _getRetryWidget(ErrorType errorType) => RetryWidget(
      errorType: errorType,
      onRetry: onRetry
  );
}

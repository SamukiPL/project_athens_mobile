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

  final Widget? initialLoading;
  final Widget? child;
  final Widget Function()? childBuilder;
  final Widget? noData;
  final String? noDataText;
  final Function(ErrorType)? retryWidget;
  final VoidCallback? onRetry;
  final bool invertLoaderColor;

  final Color color;

  const DataLoadingWidget(
      this._bloc,
      {Key? key,
      this.initialLoading,
      this.child,
      this.childBuilder,
      this.noData,
      this.noDataText,
      this.retryWidget,
      this.onRetry,
      this.color = Colors.black,
      this.invertLoaderColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataLoadingBloc>.value(
      value: _bloc,
      child: Consumer<DataLoadingBloc>(builder: (context, bloc, _) {
        switch (bloc.loadingState.runtimeType) {
          case InitialLoading:
            return _getInitialLoading();
          case ContentLoaded:
            return child ?? childBuilder!();
          case NoDataLoaded:
            return _getNoData();
          case LoadingError:
            LoadingError loadingError = bloc.loadingState as LoadingError;
            return _getRetryWidget(loadingError.errorType);
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
    child: Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        widthFactor: 10,
        heightFactor: 10,
        child: CircularProgressIndicator(
            valueColor: invertLoaderColor ? AlwaysStoppedAnimation<Color>(Colors.white) : null
        )
      ),
    )
  );

  Widget _getNoData() {
    return noData ?? _buildBaseNoData();
  }

  Widget _buildBaseNoData() => NoData(
    text: noDataText,
    color: color,
  );
  
  Widget _getRetryWidget(ErrorType errorType) {
    if (retryWidget == null && onRetry == null)
      return _getNoData();

    return retryWidget?.call(errorType) ?? _buildBaseRetry(errorType);
  }

  Widget _buildBaseRetry(ErrorType errorType) => RetryWidget(
    errorType: errorType,
    onRetry: onRetry!,
    color: color,
  );
}

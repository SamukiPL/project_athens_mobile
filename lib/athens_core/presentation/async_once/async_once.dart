import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/domain/async_once/async_once_use_case.dart';
import 'package:project_athens/athens_core/presentation/async_once/async_once_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_widget.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:provider/provider.dart';

class AsyncOnce<T> extends StatelessWidget {
  final AsyncOnceUseCase asyncOnceUseCase;

  final Widget initialLoading;
  final Widget Function(T) builder;
  final Widget noData;
  final String noDataText;
  final Function(ErrorType) retryWidget;
  final bool canRetry;

  final Color color;

  const AsyncOnce(
      {Key key,
      @required this.asyncOnceUseCase,
      this.initialLoading,
      @required this.builder,
      this.noData,
      this.noDataText,
      this.retryWidget,
      this.canRetry = false,
      this.color})
      : assert(asyncOnceUseCase != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = AsyncOnceBloc<T>(asyncOnceUseCase);
    return DataLoadingWidget(
      bloc.dataLoadingBloc,
      child: StreamProvider<T>.value(
        value: bloc.state,
        child: Consumer<T>(
          builder: (context, value, _) => (value != null) ? builder(value) : Container(),
        ),
      ),
      initialLoading: initialLoading,
      noData: noData,
      noDataText: noDataText,
      retryWidget: retryWidget,
      onRetry: (canRetry) ? () => bloc.asyncOnce() : null,
      color: color,
    );
  }
}
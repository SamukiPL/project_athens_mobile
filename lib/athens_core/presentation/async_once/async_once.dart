import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:provider/provider.dart';

typedef asyncSourceFn<T> = Future<Result<T>> Function(BuildContext context);
typedef childFn<T> = Widget Function(BuildContext context, T data);

class AsyncOnce<T> extends StatelessWidget {
  final asyncSourceFn<T> asyncFn;

  final Future<Result<T>> asyncSource;

  final bool canRetry;

  final childFn child;

  AsyncOnce({this.asyncFn, this.asyncSource, this.canRetry, this.child})
      : assert(asyncSource != null || asyncFn != null);

  @override
  Widget build(BuildContext context) {
    Future<Result<T>> source;

    if (asyncFn != null) {
      source = asyncFn.call(context);
    } else {
      source = asyncSource;
    }

    if (source == null) {
      throw Exception('Async source must be provided. Instead got null');
    }

    return FutureProvider(
      create: (context) => source,
      child: Consumer<Result<T>>(
        builder: (context, data, _) => _getWidget(context, data),
      )
    );
  }

  Widget _getWidget(BuildContext context, Result<T> data) {
    if (data == null) {
      // loader
      return Center(
        child: CircularProgressIndicator()
      );
    } else if (data is Success<T>) {
      // success
      return child.call(context, data.value);
    } else if (data is Failure<T>) {
      // error
    } else {
      throw Exception('Data result has to be Success<T> or Failure<T>. Instead got ' + data.runtimeType.toString());
    }
  }
}
import 'package:flutter_fimber/flutter_fimber.dart';

abstract class Result<T> {

  bool isSuccess() => this is Success<T>;
  Success<T> toSuccess() => this as Success<T>;
  bool isFailure() => this is Failure<T>;
  Failure<T> toFailure() => this as Failure<T>;
}
class Success<T> extends Result<T> {

  final T value;

  Success(this.value);

}

class Failure<T> extends Result<T> {

  final T? value;

  final Exception exception;

  Failure._(this.exception, {this.value});

  factory Failure(exceptionOrError, {T? value}) {
    if (exceptionOrError is Error) {
      Fimber.e("Some error occurred, fix your code!!!");
      Fimber.e(exceptionOrError.toString());
      Fimber.e(exceptionOrError.stackTrace.toString());
      throw exceptionOrError;
    }

    return Failure._(exceptionOrError, value: value);
  }

}

class Refresh<T> extends Result<T> {}

class WrongResultError implements Exception {
  @override
  String toString() => "WrongResultError: Unexpected Result";
}

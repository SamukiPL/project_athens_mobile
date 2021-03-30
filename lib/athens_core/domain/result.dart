import 'package:flutter_fimber/flutter_fimber.dart';

abstract class Result<T> {}
class Success<T> implements Result<T> {

  final T value;

  Success(this.value);

}

class Failure<T> implements Result<T> {

  final T value;

  final Exception exception;

  Failure._(this.exception, {this.value});

  factory Failure(exceptionOrError, {T value}) {
    if (exceptionOrError is Error) {
      Fimber.e("Some error occurred, fix your code!!!");
      Fimber.e(exceptionOrError.toString());
      throw exceptionOrError;
    }

    return Failure._(exceptionOrError, value: value);
  }

}

class Refresh<T> implements Result<T> {}

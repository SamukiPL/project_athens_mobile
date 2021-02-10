import 'package:flutter_fimber/flutter_fimber.dart';

abstract class Result<T> {}
class Success<T> implements Result<T> {

  final T value;

  Success(this.value);

}

class Failure<T> implements Result<T> {

  final Exception exception;

  Failure._(this.exception);

  factory Failure(exceptionOrError) {
    if (exceptionOrError is Error) {
      Fimber.e("Some error occurred, fix your code!!!");
      Fimber.e(exceptionOrError.toString());
      throw exceptionOrError;
    }

    return Failure._(exceptionOrError);
  }

}


import 'dart:async';

import 'package:project_athens/athens_core/domain/result.dart';

extension FutureExt<T> on Future<Result<T>> {
  Future<R> onSuccessThen<R>(FutureOr<R> onValue(Success<T> success)) =>
      then((result) {
        if (result.isSuccess()) {
          return onValue(result.toSuccess());
        }
        throw WrongResultError();
      });
}

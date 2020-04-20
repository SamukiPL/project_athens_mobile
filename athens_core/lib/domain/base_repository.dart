import 'dart:io';

import 'package:athens_core/domain/result.dart';

extension BaseRepository<T> on Future<Result<T>> {

  Future<Result<T>> safeApiCall() async {
    try {
      return await this;
    } catch(e) {
      return Failure(e);
    }
  }

}
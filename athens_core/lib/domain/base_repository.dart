import 'dart:io';

import 'package:athens_core/domain/result.dart';

extension BaseRepository on Future<Result> {

  Future<Result> safeApiCall() async {
    try {
      return await this;
    } catch(e) {
      return Failure(e);
    }
  }

}
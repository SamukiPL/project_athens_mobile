import 'package:drift/drift.dart';

extension ValueExt<T> on Value<T> {
  static Value<T> absentIfNull<T>(T? value) {
    if (value == null) {
      return Value.absent();
    }
    return Value.ofNullable(value);
  }

}
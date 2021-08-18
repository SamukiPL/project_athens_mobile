T requiredNotNull<T>(T? param) {
  if (param == null) {
    throw ArgumentError.notNull();
  }

  return param;
}
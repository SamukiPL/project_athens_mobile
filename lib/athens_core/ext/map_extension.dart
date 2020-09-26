extension MapExtension<T, R> on Map<T, R> {

  void putIfNotNull(T key, R value) {
    if (value != null)
      this[key] = value;
  }

}

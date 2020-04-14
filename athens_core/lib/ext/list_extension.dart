extension ListExtension<T> on List<T> {
  T removeLastIfPossible() {
    return (this.length > 1) ? this.removeLast() : this.last;
  }
}

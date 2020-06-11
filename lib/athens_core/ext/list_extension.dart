extension ListExtension<T> on List<T> {
  T removeLastIfPossible() {
    return (this.length > 1) ? this.removeLast() : this.last;
  }

  List<T> operator +(List<T> anotherList) {
    this.addAll(anotherList);
    return this;
  }

  List<T> distinct() {
    return this.toSet().toList();
  }

}

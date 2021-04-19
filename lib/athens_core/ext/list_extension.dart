extension ListExtension<T> on List<T> {
  T removeLastIfPossible() {
    return (isThereMoreThanOneItem()) ? this.removeLast() : this.last;
  }

  bool isThereMoreThanOneItem() => this.length > 1;

  List<T> operator +(List<T> anotherList) {
    this.addAll(anotherList);
    return this;
  }

  List<T> distinct() {
    return this.toSet().toList();
  }

}

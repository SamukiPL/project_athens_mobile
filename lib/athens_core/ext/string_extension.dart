extension StringExtension on String {

  bool containsIgnoreCase(String test) {
    return toLowerCase().contains(test.toLowerCase());
  }

  String toCapitalCase() {
    if (this.length > 0) {
      return this.substring(0, 1).toUpperCase() + this.substring(1);
    } else {
      return this;
    }
  }
}
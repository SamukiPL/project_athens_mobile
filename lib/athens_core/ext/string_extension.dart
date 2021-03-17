extension StringExtension on String {

  bool containsIgnoreCase(String test) {
    return toLowerCase().contains(test.toLowerCase());
  }

}
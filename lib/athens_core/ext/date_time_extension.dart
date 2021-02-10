extension DateTimeExtension on DateTime {

  static DateTime defaultFrom() => DateTime.now().subtract(Duration(days: 31));
  static DateTime defaultTo() => DateTime.now();

}
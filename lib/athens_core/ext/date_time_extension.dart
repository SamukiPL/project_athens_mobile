extension DateTimeExtension on DateTime {

  static DateTime defaultFrom() => DateTime.now().subtract(Duration(days: 31));
  static DateTime defaultTo() => DateTime.now();

  bool get isToday {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == this.day &&
        yesterday.month == this.month &&
        yesterday.year == this.year;
  }
}
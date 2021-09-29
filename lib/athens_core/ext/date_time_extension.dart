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

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return tomorrow.day == this.day &&
        tomorrow.month == this.month &&
        tomorrow.year == this.year;
  }

  DateTime getClosestDate(List<DateTime> dateTimes) {
    final closetsDateTimeToCurrent = dateTimes.reduce(
      (a, b) => a.difference(this).abs() < b.difference(this).abs() ? a : b
    );

    return closetsDateTimeToCurrent;
  }

  /// Due to bug in checking difference like DateTime.difference(DateTime)
  /// it may return rounded down int
  int getDaysBetween(DateTime betweenTo) {
    DateTime from = DateTime(this.year, this.month, this.day);
    DateTime to = DateTime(betweenTo.year, betweenTo.month, betweenTo.day);
    return (to.difference(from).inHours / 24).round();
  }
}
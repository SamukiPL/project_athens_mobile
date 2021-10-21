class DashboardParams {
  final int cadence;
  bool? meeting;
  bool? voteAbsent;
  bool? monthMeetings;
  bool? speechesCounter;
  bool? speechesCounterPerYear;
  bool? voteAbsentPerYear;

  DashboardParams({
      required this.cadence,
      this.meeting = false,
      this.voteAbsent = false,
      this.monthMeetings = false,
      this.speechesCounter = false,
      this.speechesCounterPerYear = false,
      this.voteAbsentPerYear = false
  });
}

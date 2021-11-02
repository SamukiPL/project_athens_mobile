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

  factory DashboardParams.fetchAll(final int cadence) {
    return DashboardParams(
      cadence: cadence,
      meeting: true,
      voteAbsent: true,
      monthMeetings: true,
      speechesCounter: true,
      speechesCounterPerYear: true,
      voteAbsentPerYear: true,
    );
  }

  resetParams() {
    meeting = false;
    voteAbsent = false;
    monthMeetings = false;
    speechesCounter = false;
    speechesCounterPerYear = false;
    voteAbsentPerYear = false;
  }

  isAnyDirty() {
    if (meeting != null && meeting == true) { return true; }
    if (voteAbsent != null && voteAbsent == true) { return true; }
    if (monthMeetings != null && monthMeetings == true) { return true; }
    if (speechesCounter != null && speechesCounter == true) { return true; }
    if (speechesCounterPerYear != null && speechesCounterPerYear == true) { return true; }
    if (voteAbsentPerYear != null && voteAbsentPerYear == true) { return true; }
  }
}

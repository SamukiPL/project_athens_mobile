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

  factory DashboardParams.allPristine({required final int cadence}) {
    final DashboardParams params = DashboardParams(cadence: cadence);
    params.resetParams();

    return params;
  }

  void resetParams() {
    meeting = false;
    voteAbsent = false;
    monthMeetings = false;
    speechesCounter = false;
    speechesCounterPerYear = false;
    voteAbsentPerYear = false;
  }

  bool isAnyDirty() {
    return meeting == true ||
      voteAbsent == true ||
      monthMeetings == true ||
      speechesCounter == true ||
      speechesCounterPerYear == true ||
      voteAbsentPerYear == true;
  }
}

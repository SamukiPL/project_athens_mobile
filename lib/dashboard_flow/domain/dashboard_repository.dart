import 'package:project_athens/athens_core/domain/result.dart';

abstract class DashboardRepository {

  Future<Result> getDashboard(
      int cadence,
      bool? meeting,
      bool? voteAbsent,
      bool? monthMeetings,
      bool? speechesCounter,
      bool? speechesCounterPerYear,
      bool? voteAbsentPerYear
  );
}

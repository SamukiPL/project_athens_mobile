import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/dashboard_flow/data/network/dashboard_api.dart';
import 'package:project_athens/dashboard_flow/data/network/response/dashboard_response.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardApi dashboardApi;
  // final DashboardModelMapper networkMapper;

  DashboardRepositoryImpl(this.dashboardApi);

  @override
  Future<Result<DashboardResponse>> getDashboard(
      int cadence,
      bool? meeting,
      bool? voteAbsent,
      bool? monthMeetings,
      bool? speechesCounter,
      bool? speechesCounterPerYear,
      bool? voteAbsentPerYear
  ) async {
    final response = await dashboardApi.getDashboard(
        cadence, meeting, voteAbsent, monthMeetings, speechesCounter, speechesCounterPerYear, voteAbsentPerYear
    );

    // final values = response.nouns.length > 0 ? response.nouns : List<NounTag>.empty();

    return Success(response);
  }


}

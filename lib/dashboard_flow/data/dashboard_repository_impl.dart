import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/dashboard_flow/data/network/dashboard_api.dart';
import 'package:project_athens/dashboard_flow/data/network/response/dashboard_response.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_params.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardApi dashboardApi;

  DashboardRepositoryImpl(this.dashboardApi);

  @override
  Future<Result<DashboardResponse>> getDashboard(DashboardParams params) async {
    final response = await dashboardApi.getDashboard(
        params.meeting,
        params.voteAbsent,
        params.monthMeetings,
        params.speechesCounter,
        params.speechesCounterPerYear,
        params.voteAbsentPerYear
    );
    return Success(response);
  }


}

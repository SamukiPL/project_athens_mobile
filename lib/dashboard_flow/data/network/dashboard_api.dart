import 'package:dio/dio.dart';
import 'package:project_athens/dashboard_flow/data/network/response/dashboard_response.dart';
import 'package:retrofit/http.dart';

part 'dashboard_api.g.dart';

@RestApi()
abstract class DashboardApi {
  factory DashboardApi(Dio dio, { String baseUrl }) = _DashboardApi;

  @GET("/user-aggregator/dashboard/{cadence}/")
  Future<DashboardResponse> getDashboard(
    @Path('cadence') int cadence,
    @Query("meeting") bool? meeting,
    @Query("voteAbsent") bool? voteAbsent,
    @Query("monthMeetings") bool? monthMeetings,
    @Query("speechesCounter") bool? speechesCounter,
    @Query("speechesCounterPerYear") bool? speechesCounterPerYear,
    @Query("voteAbsentPerYear") bool? voteAbsentPerYear
  );
}

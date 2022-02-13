import 'package:dio/dio.dart';
import 'package:project_athens/dashboard_flow/data/network/response/dashboard_response.dart';
import 'package:project_athens/dashboard_flow/data/network/response/parliament_meeting_details_response.dart';
import 'package:retrofit/http.dart';

part 'dashboard_api.g.dart';

@RestApi()
abstract class DashboardApi {
  factory DashboardApi(Dio dio, { String baseUrl }) = _DashboardApi;

  @GET("/user-aggregator/dashboard")
  Future<DashboardResponse> getDashboard(
    @Query("meeting") bool? meeting,
    @Query("voteAbsent") bool? voteAbsent,
    @Query("monthMeetings") bool? monthMeetings,
    @Query("speechesCounter") bool? speechesCounter,
    @Query("speechesCounterPerYear") bool? speechesCounterPerYear,
    @Query("voteAbsentPerYear") bool? voteAbsentPerYear
  );

  @GET("/user-aggregator/timeline/parliament-meetings/{parliamentMeetingId}")
  Future<ParliamentMeetingDetailsResponse> getParliamentMeetingDetails(@Path("parliamentMeetingId") String parliamentMeetingId);
}


import 'package:dio/dio.dart';
import 'package:project_athens/timeline_flow/data/network/response/meetings_response.dart';
import 'package:project_athens/timeline_flow/data/network/response/noun_cloud_response.dart';
import 'package:project_athens/athens_core/data/base_responses/timeline_response.dart';
import 'package:retrofit/http.dart';

part 'timeline_api.g.dart';

@RestApi()
abstract class TimelineApi {
  factory TimelineApi(Dio dio, {String baseUrl}) = _TimelineApi;

  @GET("/user-aggregator/timeline/{cadency}/parliament-meetings")
  Future<MeetingsResponse> getMeetingsDates(
      @Path("cadency") int cadency);

  @GET("/user-aggregator/timeline/{cadency}/{date}")
  Future<TimelineResponse> getAllDeputies(
      @Path("cadency") int cadency, @Path("date") String date);

  @GET("/user-aggregator/timeline/{cadency}/{date}/noun-cloud")
  Future<NounCloudResponse> getNounCloud(
      @Path("cadency") int cadency, @Path("date") String date);
}

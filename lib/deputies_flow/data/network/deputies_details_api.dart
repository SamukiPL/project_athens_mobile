import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/data/base_requests/base_fetch_query.dart';
import 'package:retrofit/http.dart';
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';


@RestApi()
abstract class DeputiesDetailsApi {
  factory DeputiesDetailsApi(Dio dio, { String baseUrl }) = _DeputiesDetailsApi;

  @POST("/deputy-aggregator/cadency-speech/deputy/{cadencyDeputyId}")
  Future<List<SpeechResponse>> getSpeechesByDeputy(
      @Path("cadencyDeputyId") String cadencyDeputyId,
      @Body() BaseFetchQuery query
  );

  @POST("/deputy-aggregator/cadency-voting/{cadency}/deputy/{cadencyDeputyId}")
  Future<List<VotingResponse>> getVotesByDeputy(
      @Path("cadency") int cadency,
      @Path("cadencyDeputyId") String cadencyDeputyId,
      @Body() BaseFetchQuery query
  );
}
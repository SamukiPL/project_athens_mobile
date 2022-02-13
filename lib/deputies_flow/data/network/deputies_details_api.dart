import 'package:dio/dio.dart';
import 'package:project_athens/deputies_flow/data/network/response/deputy_vote_accuracy_response.dart';
import 'package:project_athens/speeches_flow/data/network/request/speech_search_request.dart';
import 'package:project_athens/voting_flow/data/network/request/vote_search_request.dart';
import 'package:retrofit/http.dart';
import 'package:project_athens/athens_core/data/base_responses/voting_response.dart';
import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';

part 'deputies_details_api.g.dart';

@RestApi()
abstract class DeputiesDetailsApi {
  factory DeputiesDetailsApi(Dio dio, { String baseUrl }) = _DeputiesDetailsApi;

  @POST("/deputy-aggregator/cadency-speech/deputy/{cadencyDeputyId}")
  Future<List<SpeechResponse>> getSpeechesByDeputy(
      @Path("cadencyDeputyId") String cadencyDeputyId,
      @Body() SpeechSearchRequest query
  );

  @POST("/deputy-aggregator/cadency-voting/deputy/{cadencyDeputyId}")
  Future<List<VotingResponse>> getVotesByDeputy(
      @Path("cadencyDeputyId") String cadencyDeputyId,
      @Body() VoteSearchRequest query
  );

  @POST('/deputy-aggregator/cadency-deputy/{cadencyDeputyId}/vote-accuracy/{parliamentClubId}/{accuracyType}')
  Future<DeputyVoteAccuracyResponse> getDeputyVoteAccuracy(
      @Path("cadencyDeputyId") String cadencyDeputyId,
      @Path("parliamentClubId") String parliamentClubId,
      @Path('accuracyType') String accuracyType,
      @Body() VoteSearchRequest query
  );
}

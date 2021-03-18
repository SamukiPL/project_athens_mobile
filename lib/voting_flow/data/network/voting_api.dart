import 'package:dio/dio.dart';
import 'package:project_athens/voting_flow/data/network/request/vote_search_request.dart';
import 'package:project_athens/voting_flow/data/network/response/vote_search_response.dart';
import 'package:retrofit/http.dart';

part 'voting_api.g.dart';

@RestApi()
abstract class VotingApi {

  factory VotingApi(Dio dio, {String baseUrl}) = _VotingApi;

  @POST("/deputy-aggregator/cadency-voting/9/search")
  Future<VoteSearchResponse> getVoting(@Body() VoteSearchRequest request);

}
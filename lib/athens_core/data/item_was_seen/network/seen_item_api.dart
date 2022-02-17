import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'seen_item_api.g.dart';

@RestApi()
abstract class SeenItemApi {

  factory SeenItemApi(Dio dio, {String baseUrl}) = _SeenItemApi;

  @PUT("/user-aggregator/activity/vote/{voteId}")
  Future<void> setVoteSeen(@Path("voteId") String voteId);

  @PUT("/user-aggregator/activity/speech/{speechId}")
  Future<void> setSpeechSeen(@Path("speechId") String speechId);
}
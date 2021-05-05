import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';
import 'package:project_athens/speeches_flow/data/network/request/speech_search_request.dart';
import 'package:project_athens/speeches_flow/data/network/response/speeches_search_response.dart';
import 'package:retrofit/http.dart';

part 'speeches_api.g.dart';

@RestApi()
abstract class SpeechesApi  {

  factory SpeechesApi(Dio dio, {String baseUrl}) = _SpeechesApi;

  @GET("/deputy-aggregator/cadency-speech/{id}")
  Future<SpeechResponse> getSpeech(@Path("id") String speechId);

  @POST("/deputy-aggregator/cadency-speech/search")
  Future<SpeechesSearchResponse> getSpeeches(@Body() SpeechSearchRequest request);

}
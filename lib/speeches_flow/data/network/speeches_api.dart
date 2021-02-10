import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/data/base_responses/speech_response.dart';
import 'package:project_athens/speeches_flow/data/network/request/speech_search_request.dart';
import 'package:retrofit/http.dart';

part 'speeches_api.g.dart';

@RestApi()
abstract class SpeechesApi  {

  factory SpeechesApi(Dio dio, {String baseUrl}) = _SpeechesApi;

  @POST("/deputy-aggregator/cadency-speech/search")
  Future<List<SpeechResponse>> getAllDeputies(@Body() SpeechSearchRequest request);

}
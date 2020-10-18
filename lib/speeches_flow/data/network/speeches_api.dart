import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'speeches_api.g.dart';

@RestApi()
abstract class SpeechesApi  {

  factory SpeechesApi(Dio dio, {String baseUrl}) = _SpeechesApi;

}
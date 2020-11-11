import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'voting_api.g.dart';

@RestApi()
abstract class VotingApi {

  factory VotingApi(Dio dio, {String baseUrl}) = _VotingApi;

}
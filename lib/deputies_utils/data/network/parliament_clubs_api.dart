import 'package:dio/dio.dart';
import 'package:project_athens/deputies_utils/data/network/response/parliament_club_response.dart';
import 'package:retrofit/http.dart';

part 'parliament_clubs_api.g.dart';

@RestApi()
abstract class ParliamentClubsApi {
  factory ParliamentClubsApi(Dio dio, {String baseUrl}) = _ParliamentClubsApi;

  @GET("/deputy-aggregator/cadency-parliament-club")
  Future<ParliamentClubResponse> geParliamentClubs();
}

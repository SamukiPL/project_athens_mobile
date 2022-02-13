import 'package:dio/dio.dart';
import 'package:project_athens/deputies_utils/data/network/request/put_deputies_request.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_nouns_response.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';
import 'package:project_athens/deputies_utils/data/network/response/full_deputy_response.dart';
import 'package:project_athens/deputies_utils/data/network/response/subscribed_deputy_response.dart';
import 'package:retrofit/http.dart';

part 'deputies_api.g.dart';

@RestApi()
abstract class DeputiesApi {

  factory DeputiesApi(Dio dio, {String baseUrl}) = _DeputiesApi;

  @GET("/deputy-aggregator/cadency-deputy/get-all")
  Future<List<DeputyResponse>> getAllDeputies();

  @GET('/deputy-aggregator/cadency-deputy/{cadencyDeputyId}')
  Future<FullDeputyResponse> getDeputy(@Path("cadencyDeputyId") String cadencyDeputyId);

  @GET('/deputy-aggregator/cadency-deputy/{cadencyDeputyId}/noun-cloud')
  Future<DeputyNounsResponse> getDeputyNouns(@Path('cadencyDeputyId') String cadencyDeputyId);

  @PUT("/user-aggregator/deputy-subscribe")
  Future<void> putDeputies(@Body() PutDeputiesRequest request);

  @GET("/user-aggregator/deputy-subscribe")
  Future<List<SubscribedDeputyResponse>> getSubscribedDeputies();

  @DELETE("/user-aggregator/deputy-subscribe/{cadencyDeputyId}")
  Future<void> deleteDeputy(@Path("cadencyDeputyId") String cadencyDeputyId);

}
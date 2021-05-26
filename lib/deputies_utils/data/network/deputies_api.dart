import 'package:dio/dio.dart';
import 'package:project_athens/deputies_utils/data/network/request/put_deputies_request.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_nouns_response.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';
import 'package:project_athens/deputies_utils/data/network/response/subscribed_deputy_response.dart';
import 'package:retrofit/http.dart';

part 'deputies_api.g.dart';

@RestApi()
abstract class DeputiesApi {

  factory DeputiesApi(Dio dio, {String baseUrl}) = _DeputiesApi;

  @GET("/deputy-aggregator/cadency-deputy/get-all/{cadency}")
  Future<List<DeputyResponse>> getAllDeputies(@Path("cadency") int cadency);

  @GET('/deputy-aggregator/cadency-deputy/{cadencyDeputyId}')
  Future<DeputyResponse> getDeputy(@Path("cadencyDeputyId") String cadencyDeputyId);

  @GET('/deputy-aggregator/cadency-deputy/{cadencyDeputyId}/noun-cloud')
  Future<DeputyNounsResponse> getDeputyNouns(@Path('cadencyDeputyId') String cadencyDeputyId);

  @PUT("/user-aggregator/deputy-subscribe/{cadency}")
  Future<void> putDeputies(@Path("cadency") int cadency, @Body() PutDeputiesRequest request);

  @GET("/user-aggregator/deputy-subscribe/{cadency}")
  Future<List<SubscribedDeputyResponse>> getSubscribedDeputies(@Path("cadency") int cadency);

  @DELETE("/user-aggregator/deputy-subscribe/{cadency}/{cadencyDeputyId}")
  Future<void> deleteDeputy(@Path("cadency") int cadency, @Path("cadencyDeputyId") String cadencyDeputyId);

}
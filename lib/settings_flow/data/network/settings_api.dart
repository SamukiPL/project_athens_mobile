import 'package:dio/dio.dart';
import 'package:project_athens/settings_flow/data/network/response/get_backers_response.dart';
import 'package:retrofit/http.dart';



part 'settings_api.g.dart';

@RestApi()
abstract class SettingsApi {

  factory SettingsApi(Dio dio, {String baseUrl}) = _SettingsApi;

  @POST('/user-aggregator/auth/logout')
  Future<void> logout();

  @GET('/user-aggregator/crowd-funding/backers')
  Future<GetBackersResponse> getBackers();
}
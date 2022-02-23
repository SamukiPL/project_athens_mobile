import 'package:dio/dio.dart';
import 'package:project_athens/more_flow/data/network/request/delete_account_request.dart';
import 'package:project_athens/more_flow/data/network/response/get_backers_response.dart';
import 'package:retrofit/http.dart';

part 'more_api.g.dart';

@RestApi()
abstract class MoreApi {

  factory MoreApi(Dio dio, {String baseUrl}) = _MoreApi;

  @POST('/user-aggregator/auth/logout')
  Future<void> logout();

  @GET('/user-aggregator/crowd-funding/backers')
  Future<GetBackersResponse> getBackers();

  @POST('/user-aggregator/user-manage/delete-account-request')
  Future<void> deleteAccountRequest(@Body() DeleteAccountRequest request);
}

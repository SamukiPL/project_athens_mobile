import 'package:dio/dio.dart';
import 'package:project_athens/authorization_flow/data/network/request/check_pair_usage_request.dart';
import 'package:project_athens/authorization_flow/data/network/request/login_request.dart';
import 'package:project_athens/authorization_flow/data/network/request/reset_password_request.dart';
import 'package:project_athens/authorization_flow/data/network/request/registration_request.dart';
import 'package:project_athens/authorization_flow/data/network/response/check_pair_usage_response.dart';
import 'package:project_athens/authorization_flow/data/network/response/login_response.dart';
import 'package:project_athens/authorization_flow/data/network/response/reset_password_response.dart';
import 'package:project_athens/deputies_utils/data/network/response/deputy_response.dart';
import 'package:retrofit/http.dart';

part 'login_api.g.dart';

@RestApi()
abstract class LoginApi {

  factory LoginApi(Dio dio, {String baseUrl}) = _LoginApi;

  @POST('/user-aggregator/auth/login')
  Future<LoginResponse> logIn(@Body() LoginRequest request);

  @POST('/user-aggregator/auth/register')
  Future<LoginResponse> register(@Body() RegistrationRequest request);

  @POST('/user-aggregator/auth/reset-password')
  Future<ResetPasswordResponse> resetPassword(@Body() ResetPasswordRequest request);

  @POST('/user-aggregator/auth/register-pair-usage')
  Future<CheckPairUsageResponse> checkAccountPairUsage(@Body() CheckPairUsageRequest request);

  @GET("/deputy-aggregator/cadency-deputy/get-all")
  Future<List<DeputyResponse>> getAllDeputies();

}
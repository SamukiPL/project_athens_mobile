import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/auth/network/auth_response.dart';
import 'package:retrofit/http.dart';

import 'auth_request.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {

  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/user-aggregator/auth/auth')
  Future<AuthResponse> refreshTokens(@Body() AuthRequest request);

}
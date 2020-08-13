import 'package:project_athens/authorization_flow/data/network/request/check_pair_usage_request.dart';
import 'package:project_athens/authorization_flow/data/network/request/login_request.dart';
import 'package:project_athens/authorization_flow/data/network/request/reset_password_request.dart';
import 'package:project_athens/authorization_flow/data/network/request/registration_request.dart';
import 'package:chopper/chopper.dart';

part 'login_api.chopper.dart';

@ChopperApi()
abstract class LoginApi extends ChopperService {

  static LoginApi create([ChopperClient client]) =>
      _$LoginApi(client);

  @Post(path: '/user-aggregator/auth/login')
  Future<Response> logIn(@Body() LoginRequest request);

  @Post(path: '/user-aggregator/auth/register')
  Future<Response> register(@Body() RegistrationRequest request);

  @Post(path: '/user-aggregator/auth/reset-password')
  Future<Response> resetPassword(@Body() ResetPasswordRequest request);

  @Post(path: '/user-aggregator/auth/register-pair-usage')
  Future<Response> checkAccountPairUsage(@Body() CheckPairUsageRequest request);

  @Get(path: "/deputy-aggregator/cadency-deputy/get-all/{cadency}")
  Future<Response> getAllDeputies(@Path("cadency") int cadency);

}
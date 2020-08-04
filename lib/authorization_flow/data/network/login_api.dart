import 'package:project_athens/authorization_flow/data/network/request/check_pair_usage_request.dart';
import 'package:project_athens/authorization_flow/data/network/request/login_request.dart';
import 'package:project_athens/authorization_flow/data/network/request/reset_password_request.dart';
import 'package:project_athens/authorization_flow/data/network/request/registration_request.dart';
import 'package:chopper/chopper.dart';

part 'login_api.chopper.dart';

@ChopperApi(baseUrl: "/user-aggregator/auth")
abstract class LoginApi extends ChopperService {

  static LoginApi create([ChopperClient client]) =>
      _$LoginApi(client);

  @Post(path: '/login')
  Future<Response> logIn(@Body() LoginRequest request);

  @Post(path: '/register')
  Future<Response> register(@Body() RegistrationRequest request);

  @Post(path: '/reset-password')
  Future<Response> resetPassword(@Body() ResetPasswordRequest request);

  @Post(path: '/register-pair-usage')
  Future<Response> checkAccountPairUsage(@Body() CheckPairUsageRequest request);

}
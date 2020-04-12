import 'package:chopper/chopper.dart';

import 'auth_request.dart';

part "auth_api.chopper.dart";

@ChopperApi(baseUrl: "/user-aggregator/auth")
abstract class AuthApi extends ChopperService {

  static AuthApi create([ChopperClient client]) =>
      _$AuthApi(client);

  @Post(path: '/auth')
  Future<Response> refreshTokens(@Body() AuthRequest request);

}
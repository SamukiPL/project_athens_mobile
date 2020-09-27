import 'package:chopper/chopper.dart';

part 'settings_api.chopper.dart';

@ChopperApi(baseUrl: "/user-aggregator/auth")
abstract class SettingsApi extends ChopperService {

  static SettingsApi create([ChopperClient client]) =>
      _$SettingsApi(client);

  @Post(path: '/logout')
  Future<Response> logout();

}
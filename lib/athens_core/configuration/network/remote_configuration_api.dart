import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/configuration/network/get_remote_configuration_response.dart';
import 'package:retrofit/http.dart';

part 'remote_configuration_api.g.dart';

@RestApi()
abstract class RemoteConfigurationApi {

  factory RemoteConfigurationApi(Dio dio, {String baseUrl}) = _RemoteConfigurationApi;

  @GET('/user-aggregator/config')
  Future<GetRemoteConfigurationResponse> getRemoteConfiguration();
}

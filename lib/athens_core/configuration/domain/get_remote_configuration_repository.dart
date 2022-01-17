import 'package:project_athens/athens_core/configuration/network/get_remote_configuration_response.dart';
import 'package:project_athens/athens_core/domain/result.dart';

abstract class GetRemoteConfigurationRepository {
  Future<Result<GetRemoteConfigurationResponse>> getRemoteConfiguration();
}

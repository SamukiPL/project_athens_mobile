import 'package:project_athens/athens_core/configuration/domain/get_remote_configuration_repository.dart';
import 'package:project_athens/athens_core/configuration/network/get_remote_configuration_response.dart';
import 'package:project_athens/athens_core/configuration/network/remote_configuration_api.dart';
import 'package:project_athens/athens_core/domain/result.dart';

class GetRemoteConfigurationRepositoryImpl implements GetRemoteConfigurationRepository {
  final RemoteConfigurationApi _configApi;

  GetRemoteConfigurationRepositoryImpl(this._configApi);

  @override
  Future<Result<GetRemoteConfigurationResponse>> getRemoteConfiguration() async {
    return _configApi.getRemoteConfiguration()
        .then((value) => Success(value));
  }
}

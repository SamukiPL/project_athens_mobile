import 'package:project_athens/athens_core/configuration/domain/get_remote_configuration_repository.dart';
import 'package:project_athens/athens_core/configuration/network/get_remote_configuration_response.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';

class GetRemoteConfigurationUseCase extends BaseUseCase<BaseParams> {
  final GetRemoteConfigurationRepository _repository;

  GetRemoteConfigurationUseCase(this._repository);

  @override
  Future<Result<GetRemoteConfigurationResponse>> call(BaseParams params) {
    return _repository.getRemoteConfiguration().safeApiCall();
  }
}

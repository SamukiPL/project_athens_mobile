import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/settings_flow/domain/settings/logout_repository.dart';

class LogoutUseCase extends BaseUseCase<BaseParams> {

  final LogoutRepository _logoutRepository;

  LogoutUseCase(this._logoutRepository);

  @override
  Future<Result> call(BaseParams params) {
    return _logoutRepository.logout();
  }

}
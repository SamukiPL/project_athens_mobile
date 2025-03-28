import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/more_flow/domain/more/logout_repository.dart';

class LogoutUseCase extends BaseUseCase {
  final LogoutRepository _logoutRepository;

  LogoutUseCase(this._logoutRepository);

  Future<Result> call(params) {
    return _logoutRepository.logout();
  }
}

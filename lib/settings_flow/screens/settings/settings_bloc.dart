import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:project_athens/settings_flow/domain/settings/logout_use_case.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class SettingsBloc extends BaseBloc {

  final LogoutUseCase _logoutUseCase;

  SettingsBloc(this._logoutUseCase);

  Future<void> logout() async {
    final result = await _logoutUseCase(null).safeApiCall();
    manageState(result);
  }
}
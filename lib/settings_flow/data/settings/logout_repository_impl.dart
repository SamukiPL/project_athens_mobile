import 'package:project_athens/athens_core/auth/auth_storage.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/settings_flow/data/network/settings_api.dart';
import 'package:project_athens/settings_flow/domain/settings/logout_repository.dart';

class LogoutRepositoryImpl extends LogoutRepository {

  final SettingsApi _settingsApi;

  final AuthStorage storage = AuthStorage();

  LogoutRepositoryImpl(this._settingsApi);

  @override
  Future<Result<bool>> logout() async {
    await _settingsApi.logout();
    await storage.removeTokens();

    return Success(true);
  }

}
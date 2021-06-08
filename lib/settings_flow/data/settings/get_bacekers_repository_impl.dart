import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/settings_flow/data/network/response/get_backers_response.dart';
import 'package:project_athens/settings_flow/data/network/settings_api.dart';
import 'package:project_athens/settings_flow/domain/settings/get_backers_repository.dart';

class GetBackersRepositroyImpl extends GetBackersRepository {
  final SettingsApi _settingsApi;

  GetBackersRepositroyImpl(this._settingsApi);

  Future<Result<GetBackersResponse>> getBackers() async {
      final response = await _settingsApi.getBackers();

    return Success(response);
  }
}
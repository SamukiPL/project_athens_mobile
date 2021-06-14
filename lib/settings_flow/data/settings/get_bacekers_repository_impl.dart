import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/settings_flow/data/network/settings_api.dart';
import 'package:project_athens/settings_flow/domain/settings/backer.dart';
import 'package:project_athens/settings_flow/domain/settings/get_backers_repository.dart';

class GetBackersRepositroyImpl extends GetBackersRepository {
  final SettingsApi _settingsApi;

  GetBackersRepositroyImpl(this._settingsApi);

  Future<Result<List<BackerModel>>> getBackers() async {
    final response = await _settingsApi.getBackers();

    final backers = response.backers
        .map((e) => BackerModel(e.nickname, e.amount, e.hasBadge, e.comment, e.backedAt, e.isCurrentUser))
        .toList();
    return Success(backers);
  }
}
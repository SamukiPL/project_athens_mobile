import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';
import 'package:project_athens/athens_core/auto_updater/auto_updater.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/more_flow/domain/more/logout_use_case.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class MoreBloc extends BaseBloc {
  final LogoutUseCase _logoutUseCase;
  final AutoUpdater _autoUpdater;
  final String _crowdFundingSite = 'https://zrzutka.pl/z/demokracja-app';

  Stream<bool> get checkingForUpdateStream =>
      _autoUpdater.checkingForUpdateStream;

  MoreBloc(this._logoutUseCase, this._autoUpdater);

  Future<void> logout() async {
    final result = await _logoutUseCase(null).safeApiCall();
    manageState(result);
  }

  void goToCrowdFundingPage() async {
    if (await canLaunch(_crowdFundingSite)) {
      launch(_crowdFundingSite);
    }
  }

  Future<void> checkForUpdates() {
    return _autoUpdater.checkForUpdates();
  }

  Future<String> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return packageInfo.version;
  }
}

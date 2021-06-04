import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/settings_flow/domain/settings/logout_use_case.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsBloc extends BaseBloc {

  final LogoutUseCase _logoutUseCase;
  final String _crowdFundingSite = 'https://zrzutka.pl/z/demokracja-app';

  SettingsBloc(this._logoutUseCase);

  Future<void> logout() async {
    final result = await _logoutUseCase(null).safeApiCall();
    manageState(result);
  }
  
  void goToCrowdFundingPage() async {
    if (await canLaunch(_crowdFundingSite)) {
      launch(_crowdFundingSite);
    }
  }
}
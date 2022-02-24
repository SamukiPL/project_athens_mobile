import 'package:project_athens/athens_core/chopper/auth_facade.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';

class GuestBlockadeBloc extends BaseBloc {
  final AuthFacade _authFacade;

  GuestBlockadeBloc(this._authFacade);

  Future<void> clearTokens() async {
    _authFacade.clearTokens();
  }
}
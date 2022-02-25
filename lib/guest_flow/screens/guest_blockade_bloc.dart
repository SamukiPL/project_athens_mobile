import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/guest_flow/domain/logout_guest_use_case.dart';

class GuestBlockadeBloc extends BaseBloc {
  final LogoutGuestUseCase _logoutGuestUseCase;

  GuestBlockadeBloc(this._logoutGuestUseCase);

  Future<void> clearTokens() async {
    _logoutGuestUseCase();
  }
}
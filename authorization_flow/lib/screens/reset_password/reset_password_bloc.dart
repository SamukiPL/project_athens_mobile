import 'package:authorization_flow/domain/reset_password/reset_password_params.dart';
import 'package:authorization_flow/domain/reset_password/reset_password_use_case.dart';
import 'package:authorization_flow/screens/base_login_bloc.dart';
import 'package:athens_core/domain/base_repository.dart';

class ResetPasswordBloc extends BaseLoginBloc {

  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordBloc(this._resetPasswordUseCase);

  String _email = "";

  void setEmail(String email) {
    _email = email;
  }

  Future<void> resetPassword() async {
    if (_email.isEmpty) return;

    final params = ResetPasswordParams(_email);

    var result = await _resetPasswordUseCase(params).safeApiCall();
    manageState(result);
  }

}
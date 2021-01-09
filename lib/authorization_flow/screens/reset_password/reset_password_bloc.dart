import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/authorization_flow/domain/reset_password/reset_password_params.dart';
import 'package:project_athens/authorization_flow/domain/reset_password/reset_password_use_case.dart';

class ResetPasswordBloc extends BaseBloc {

  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordBloc(this._resetPasswordUseCase);

  String _email = "";

  void setEmail(String email) {
    _email = email;
  }

  Future<void> call() async {
    if (_email.isEmpty) return;

    final params = ResetPasswordParams(_email);

    var result = await _resetPasswordUseCase(params).safeApiCall();
    manageState(result);
  }

}
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:project_athens/authorization_flow/domain/reset_password/reset_password_params.dart';
import 'package:project_athens/authorization_flow/domain/reset_password/reset_password_use_case.dart';

class ResetPasswordBloc extends BaseBloc {
  final ResetPasswordUseCase _resetPasswordUseCase;

  ResetPasswordBloc(this._resetPasswordUseCase);

  final DataLoadingBloc _btnActionAwaitBloc = DataLoadingBloc();

  final GlobalKey<FormState> _resetPasswordForm = GlobalKey<FormState>();

  DataLoadingBloc get btnActionAwaitBloc => _btnActionAwaitBloc;

  GlobalKey<FormState> get resetPasswordForm => _resetPasswordForm;

  String _email = "";

  void setEmail(String email) {
    _email = email;
  }

  Future<void> call() async {
    if (_email.isEmpty) return;

    if (resetPasswordForm.currentState?.validate() == false) {
      return;
    }

    btnActionAwaitBloc.setDataLoadingState(DataLoadingState.loading());

    final params = ResetPasswordParams(_email);

    var result = await _resetPasswordUseCase(params).safeApiCall();
    if (result.isSuccess()) {
      _btnActionAwaitBloc.setDataLoadingState(DataLoadingState.contentLoaded());
    } else if (result.isFailure()) {
      _btnActionAwaitBloc.setDataLoadingState(
          DataLoadingState.error(result.toFailure().exception.getErrorType()));
    }
    manageState(result);
  }
}

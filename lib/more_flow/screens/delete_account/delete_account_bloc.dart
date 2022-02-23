import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:project_athens/more_flow/domain/more/delete_account_params.dart';
import 'package:project_athens/more_flow/domain/more/delete_account_use_case.dart';

class DeleteAccountBloc extends BaseBloc {

  DeleteAccountBloc(this._deleteAccountUseCase);

  final DataLoadingBloc deleteAccountButtonLoadingBloc = DataLoadingBloc();
  final GlobalKey<FormState> questionnaireForm = GlobalKey<FormState>();
  final DeleteAccountUseCase _deleteAccountUseCase;

  bool _applicationIsSlow = false;
  bool _notInterested = false;
  bool _manyErrors = false;
  bool _dontLikeApp = false;
  bool _confirmDelete = false;
  String? _anotherReasonValue;
  String? _additionalNotes = "";

  set applicationIsSlow(bool newValue) {
    _applicationIsSlow = newValue;
  }

  set notInterested(bool newValue) {
    _notInterested = newValue;
  }

  set manyErrors(bool newValue) {
    _manyErrors = newValue;
  }

  set dontLikeApp(bool newValue) {
    _dontLikeApp = newValue;
  }

  set anotherReasonValue(String? newValue) {
    _anotherReasonValue = newValue;
  }

  set confirmDelete(bool newValue) {
    _confirmDelete = newValue;
  }

  set additionalNotes(String? newValue) {
    _additionalNotes = newValue;
  }

  bool get isAnySelected => _applicationIsSlow
      || _notInterested
      || _manyErrors
      || _dontLikeApp
      || _anotherReasonValue != null;

  Future<void> call() async {
    if (!questionnaireForm.currentState!.validate()) {
      return;
    }

    deleteAccountButtonLoadingBloc.setDataLoadingState(DataLoadingState.loading());

    final result = await _deleteAccountUseCase(
      DeleteAccountParams(
        getReason(),
        _additionalNotes ?? "",
        null
      )
    );

    if (result.isSuccess()) {
      deleteAccountButtonLoadingBloc.setDataLoadingState(DataLoadingState.contentLoaded());
    } else {
      deleteAccountButtonLoadingBloc.setDataLoadingState(DataLoadingState.error((result as Failure).exception.getErrorType()));
    }

    return;
  }

  String getReason() {
    List<String> finalReason = List<String>.empty(growable: true);
    if (_applicationIsSlow) {
      finalReason.add("Application is slow");
    }

    if (_notInterested) {
      finalReason.add("Not interested in this kind of information");
    }

    if (_manyErrors) {
      finalReason.add("Application has lots of errors");
    }

    if (_dontLikeApp) {
      finalReason.add("Do not like the application");
    }

    if (_anotherReasonValue != null && _anotherReasonValue != "") {
      finalReason.add(_anotherReasonValue!);
    }

    return finalReason.join(" | ");
  }
}

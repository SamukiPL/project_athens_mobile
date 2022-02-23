import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/more_flow/data/network/more_api.dart';
import 'package:project_athens/more_flow/data/network/request/delete_account_request.dart';
import 'package:project_athens/more_flow/domain/more/delete_account_params.dart';
import 'package:project_athens/more_flow/domain/more/delete_account_repository.dart';

class DeleteAccountRepositoryImpl extends DeleteAccountRepository {
  final MoreApi _moreApi;

  DeleteAccountRepositoryImpl(this._moreApi);

  Future<Result<void>> deleteAccount(DeleteAccountParams params) async {
    try {
      final response = await _moreApi.deleteAccountRequest(
          DeleteAccountRequest(
              params.reason,
              params.additionalNotes,
              params.deviceInfo)
      );
      return Success(response);
    } catch(err) {
      return Failure(err);
    }
  }
}
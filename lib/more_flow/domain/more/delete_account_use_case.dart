import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/more_flow/domain/more/delete_account_params.dart';
import 'package:project_athens/more_flow/domain/more/delete_account_repository.dart';

class DeleteAccountUseCase extends BaseUseCase {
  final DeleteAccountRepository _deleteAccountRepository;

  DeleteAccountUseCase(this._deleteAccountRepository);

  Future<Result<void>> call(DeleteAccountParams params) {
    return _deleteAccountRepository.deleteAccount(params);
  }
}

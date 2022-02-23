import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/more_flow/domain/more/delete_account_params.dart';

abstract class DeleteAccountRepository {
  Future<Result<void>> deleteAccount(DeleteAccountParams params);
}

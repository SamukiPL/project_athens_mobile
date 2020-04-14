import 'package:authorization_flow/domain/reset_password/reset_password_params.dart';
import 'package:authorization_flow/domain/reset_password/reset_password_repository.dart';
import 'package:athens_core/domain/result.dart';
import 'package:athens_core/domain/base_use_case.dart';

class ResetPasswordUseCase implements BaseUseCase<ResetPasswordParams> {

  final ResetPasswordRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Result> call(ResetPasswordParams params) {
    return repository.resetPassword(params);
  }

}
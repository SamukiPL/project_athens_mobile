import 'package:project_athens/authorization_flow/domain/reset_password/reset_password_params.dart';
import 'package:project_athens/authorization_flow/domain/reset_password/reset_password_repository.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';

class ResetPasswordUseCase implements BaseUseCase {

  final ResetPasswordRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Result> call(ResetPasswordParams params) {
    return repository.resetPassword(params).safeApiCall();
  }

}
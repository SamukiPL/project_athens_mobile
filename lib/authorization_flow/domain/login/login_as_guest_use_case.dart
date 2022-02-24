import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/authorization_flow/domain/login/login_repository.dart';

class LoginAsGuestUseCase extends BaseUseCase {
  final LoginRepository repository;

  LoginAsGuestUseCase(this.repository);

  Future<Result> call() {
    return repository.loginAsGuest();
  }
}

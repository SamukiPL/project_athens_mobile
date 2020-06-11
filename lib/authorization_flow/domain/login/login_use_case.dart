import 'package:project_athens/authorization_flow/domain/login/login_params.dart';
import 'package:project_athens/authorization_flow/domain/login/login_repository.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/domain/base_use_case.dart';

class LoginUseCase implements BaseUseCase<LoginParams> {

  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Result> call(LoginParams params) {
    return repository.logIn(params);
  }

}
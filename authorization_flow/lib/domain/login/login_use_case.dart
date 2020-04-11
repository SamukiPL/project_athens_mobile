import 'package:authorization_flow/domain/login/login_params.dart';
import 'package:authorization_flow/domain/login/login_repository.dart';
import 'package:authorization_flow/domain/login/login_response.dart';

class LoginUseCase {

  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<LoginStatus> call(LoginParams params) {
    return repository.logIn(params);
  }

}
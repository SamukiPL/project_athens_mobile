import 'package:project_athens/authorization_flow/domain/login/login_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';

abstract class LoginRepository {
  Future<Result> logIn(LoginParams params);
  Future<Result> loginAsGuest();
}

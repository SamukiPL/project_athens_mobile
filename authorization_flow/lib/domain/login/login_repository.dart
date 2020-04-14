import 'package:authorization_flow/domain/login/login_params.dart';
import 'package:athens_core/domain/result.dart';

abstract class LoginRepository {

  Future<Result> logIn(LoginParams params);

}
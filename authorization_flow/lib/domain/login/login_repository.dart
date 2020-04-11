import 'package:authorization_flow/domain/login/login_params.dart';
import 'package:authorization_flow/domain/login/login_response.dart';

abstract class LoginRepository {

  Future<LoginStatus> logIn(LoginParams params);

}
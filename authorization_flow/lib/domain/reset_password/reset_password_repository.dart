import 'package:authorization_flow/domain/reset_password/reset_password_params.dart';
import 'package:athens_core/domain/result.dart';

abstract class ResetPasswordRepository {

  Future<Result> resetPassword(ResetPasswordParams params);

}
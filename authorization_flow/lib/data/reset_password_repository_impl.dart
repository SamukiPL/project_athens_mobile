import 'package:athens_core/domain/result.dart';
import 'package:authorization_flow/data/network/request/reset_password_request.dart';
import 'package:authorization_flow/domain/reset_password/reset_password_params.dart';
import 'package:authorization_flow/domain/reset_password/reset_password_repository.dart';

import 'network/login_api.dart';

class ResetPasswordRepositoryImpl implements ResetPasswordRepository {

  final LoginApi api;

  ResetPasswordRepositoryImpl(this.api);

  @override
  Future<Result> resetPassword(ResetPasswordParams params) async {
    await api.resetPassword(ResetPasswordRequest(params.email));

    return Success<bool>(true);
  }

}
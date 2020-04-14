import 'package:athens_core/injections/module.dart';
import 'package:authorization_flow/data/network/login_api.dart';
import 'package:authorization_flow/data/reset_password_repository_impl.dart';
import 'package:authorization_flow/domain/reset_password/reset_password_repository.dart';
import 'package:authorization_flow/domain/reset_password/reset_password_use_case.dart';
import 'package:authorization_flow/screens/reset_password/reset_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class ResetPasswordModule extends Module {

  ResetPasswordModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    LoginApi loginApi = Provider.of<LoginApi>(context);
    ResetPasswordRepository repository = ResetPasswordRepositoryImpl(loginApi);
    ResetPasswordUseCase useCase = ResetPasswordUseCase(repository);

    return [
      Provider<ResetPasswordBloc>(
        create: (_) => ResetPasswordBloc(useCase),
        dispose: (_, bloc) => bloc.dispose(),
      )
    ];
  }

}
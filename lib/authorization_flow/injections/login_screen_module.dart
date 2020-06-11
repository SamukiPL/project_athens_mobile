import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/authorization_flow/data/login_repository_impl.dart';
import 'package:project_athens/authorization_flow/data/network/login_api.dart';
import 'package:project_athens/authorization_flow/domain/login/login_repository.dart';
import 'package:project_athens/authorization_flow/domain/login/login_use_case.dart';
import 'package:project_athens/authorization_flow/screens/login/login_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class LoginScreenModule extends Module {

  LoginScreenModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    LoginApi loginApi = Provider.of<LoginApi>(context);
    LoginRepository loginRepository = LoginRepositoryImpl(loginApi);
    LoginUseCase loginUseCase = LoginUseCase(loginRepository);

    return List.of([
      Provider<LoginBloc>(
        create: (_) => LoginBloc(loginUseCase),
        dispose: (context, bloc) => bloc.dispose(),
      )
    ]);
  }

}

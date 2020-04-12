import 'package:authorization_flow/data/login_repository_impl.dart';
import 'package:authorization_flow/data/network/login_api.dart';
import 'package:authorization_flow/domain/login/login_repository.dart';
import 'package:authorization_flow/domain/login/login_use_case.dart';
import 'package:authorization_flow/screens/login/login_bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:athens_core/injections/module.dart';

class LoginScreenModule extends Module {

  LoginScreenModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    ChopperClient client = Provider.of<ChopperClient>(context);
    LoginApi loginApi = LoginApi.create(client);
    LoginRepository loginRepository = LoginRepositoryImpl(loginApi);
    LoginUseCase loginUseCase = LoginUseCase(loginRepository);

    return List.of([
      Provider<LoginBloc>(
        create: (_) => LoginBloc(loginUseCase),
        dispose: (context, bloc) {
          loginApi.dispose();
          bloc.dispose();
        },
      )
    ]);
  }

}

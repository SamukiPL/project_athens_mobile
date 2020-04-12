import 'package:athens_core/auth/auth_repository.dart';
import 'package:athens_core/auth/auth_repository_impl.dart';
import 'package:athens_core/auth/network/auth_api.dart';
import 'package:athens_core/injections/module.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'splash_screen_bloc.dart';
import 'splash_screen_bloc.dart';

class SplashScreenModule extends Module {

  SplashScreenModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    ChopperClient client = ChopperClient(
      baseUrl: "http://51.38.36.119:3505",
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
    AuthApi authApi = AuthApi.create(client);
    return [
      Provider<SplashScreenBloc>(
        create: (_) => SplashScreenBloc(AuthRepositoryImpl(authApi)),
        dispose: (_, bloc) {
          bloc.dispose();
          authApi.dispose();
          client.dispose();
        },
      )
    ];
  }

}
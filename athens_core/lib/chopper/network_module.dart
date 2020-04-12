import 'package:athens_core/auth/auth_repository_impl.dart';
import 'package:athens_core/auth/network/auth_api.dart';
import 'package:athens_core/chopper/auth_facade.dart';
import 'package:athens_core/chopper/auth_interceptor.dart';
import 'package:athens_core/injections/module.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class NetworkModule extends Module {

  NetworkModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final refreshClient = _getRefreshClient();
    final authApi = AuthApi.create(refreshClient);
    final authRepository = AuthRepositoryImpl(authApi);
    final authFacade = AuthFacade(authRepository);

    return [
      Provider<ChopperClient>(
        create: (BuildContext context) =>
          ChopperClient(
            interceptors: [
              HttpLoggingInterceptor(),
              AuthInterceptor(authFacade)
            ]
        ),
        dispose: (context, client) {
          authApi.dispose();
          refreshClient.dispose();
          client.dispose();
        },
      )
    ];
  }

  ChopperClient _getRefreshClient() {
    return ChopperClient(
      baseUrl: "http://51.38.36.119:3505",
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
      interceptors: [HttpLoggingInterceptor()],
    );
  }

}
import 'package:project_athens/athens_core/auth/auth_repository_impl.dart';
import 'package:project_athens/athens_core/auth/network/auth_api.dart';
import 'package:project_athens/athens_core/chopper/auth_facade.dart';
import 'package:project_athens/athens_core/chopper/auth_interceptor.dart';
import 'package:project_athens/athens_core/chopper/error_interceptor.dart';
import 'package:project_athens/athens_core/chopper/logging_interceptor.dart';
import 'package:project_athens/athens_core/chopper/network_module_simple.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class NetworkModule extends Module {
  NetworkModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final refreshClient = Provider.of<SimpleChopperClient>(context).client;
    final authApi = AuthApi.create(refreshClient);
    final authRepository = AuthRepositoryImpl(authApi);
    final authFacade = AuthFacade(authRepository);

    return [
      Provider<ChopperClient>(
        create: (BuildContext context) =>
            ChopperClient(
                baseUrl: "http://api.swiadoma-demokracja.pl",
                converter: JsonConverter(),
                errorConverter: JsonConverter(),
                interceptors: [AuthInterceptor(authFacade), ErrorInterceptor(),
                LoggingInterceptor()]),
        dispose: (context, client) {
          authApi.dispose();
          client.dispose();
        },
      )
    ];
  }

  ChopperClient _getRefreshClient() {
    return ChopperClient(
      baseUrl: "http://api.swiadoma-demokracja.pl",
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
      interceptors: [LoggingInterceptor(), ErrorInterceptor()],
    );
  }
}

import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/auth/auth_repository_impl.dart';
import 'package:project_athens/athens_core/auth/network/auth_api.dart';
import 'package:project_athens/athens_core/chopper/auth_facade.dart';
import 'package:project_athens/athens_core/chopper/auth_interceptor.dart';
import 'package:project_athens/athens_core/chopper/error_interceptor.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class NetworkModule extends Module {
  NetworkModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final refreshClient = Provider.of<SimpleDioClient>(context).client;
    final authApi = AuthApi(refreshClient);
    final authRepository = AuthRepositoryImpl(authApi);
    final authFacade = AuthFacade(authRepository);

    // final clientOptions = BaseOptions(
    //   baseUrl: "https://api.swiadoma-demokracja.pl",
    // );

    final clientOptions = BaseOptions(
      baseUrl: "http://10.0.2.2:3505",
    );

    return [
      Provider<Dio>(
        create: (BuildContext context) => Dio(clientOptions)
        ..interceptors.addAll([AuthInterceptor(authFacade), ErrorInterceptor(), LogInterceptor(requestBody: false, responseBody: false)]),
        dispose: (context, client) {
          client.close();
        },
        lazy: false,
      )
    ];
  }
}

class SimpleDioClient {

  final Dio client;

  SimpleDioClient(this.client);

  void dispose() {
    client.close();
  }

}

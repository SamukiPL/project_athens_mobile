import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/auth/auth_repository_impl.dart';
import 'package:project_athens/athens_core/auth/network/auth_api.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/chopper/simple_dio_client.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:provider/provider.dart';

import 'splash_screen_bloc.dart';

class SplashScreenModule extends Module {
  SplashScreenModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    SubscribedDeputiesCache subscribedDeputiesCache = Provider.of<SubscribedDeputiesCache>(context);
    Dio client = Provider.of<SimpleDioClient>(context).client;

    AuthApi authApi = AuthApi(client);
    return [
      Provider<SplashScreenBloc>(
        create: (_) =>
            SplashScreenBloc(AuthRepositoryImpl(authApi), subscribedDeputiesCache),
        dispose: (_, bloc) => bloc.dispose(),
      )
    ];
  }
}

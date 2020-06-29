import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
import 'package:project_athens/athens_core/auth/auth_repository_impl.dart';
import 'package:project_athens/athens_core/auth/network/auth_api.dart';
import 'package:project_athens/athens_core/chopper/error_interceptor.dart';
import 'package:project_athens/athens_core/chopper/network_module_simple.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:provider/provider.dart';

import 'splash_screen_bloc.dart';

class SplashScreenModule extends Module {

  SplashScreenModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    DeputiesCache deputiesCache = Provider.of<DeputiesCache>(context);
    ChopperClient client = Provider.of<SimpleChopperClient>(context).client;
    AuthApi authApi = AuthApi.create(client);
    return [
      Provider<SplashScreenBloc>(
        create: (_) => SplashScreenBloc(AuthRepositoryImpl(authApi), deputiesCache),
        dispose: (_, bloc) {
          bloc.dispose();
          authApi.dispose();
        },
      )
    ];
  }

}
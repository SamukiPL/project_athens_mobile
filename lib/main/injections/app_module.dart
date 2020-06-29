import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/chopper/error_interceptor.dart';
import 'package:project_athens/athens_core/chopper/logging_interceptor.dart';
import 'package:project_athens/athens_core/chopper/network_module_simple.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/data/get_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppModule extends Module {

  AppModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final client = ChopperClient(
      baseUrl: "http://51.38.36.119:3505",
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
      interceptors: [ErrorInterceptor(), LoggingInterceptor()],
    );

    final deputiesApi = DeputiesApi.create(client);
    final getDeputiesRepository = GetDeputiesRepositoryImpl(deputiesApi);
    final getDeputiesUseCase = GetDeputiesUseCase(getDeputiesRepository);

    return List<SingleChildWidget>.of([
      Provider<SimpleChopperClient>(
        create: (_) => SimpleChopperClient(client),
        dispose: (context, client) => client.dispose(),
      ),
      Provider<DeputiesCache>(
        create: (_) => DeputiesCache(getDeputiesUseCase),
        dispose: (_, __) {
          deputiesApi.dispose();
        },
      )
    ]);
  }
}
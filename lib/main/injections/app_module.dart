import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/chopper/error_interceptor.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/data/get_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/get_deputy_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/get_parliament_clubs_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/data/network/parliament_clubs_api.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy/get_deputy_repository.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy/get_deputy_use_case.dart';
import 'package:project_athens/deputies_utils/domain/get_parliament_clubs/get_parliament_clubs_use_case.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppModule extends Module {

  AppModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final clientOptions = BaseOptions(
      baseUrl: "https://api.swiadoma-demokracja.pl",
    );
    final client = Dio(clientOptions);
    client.interceptors.addAll([LogInterceptor(requestBody: true, responseBody: true), ErrorInterceptor()]);

    final deputiesApi = DeputiesApi(client);
    final getDeputiesRepository = GetDeputiesRepositoryImpl(deputiesApi);
    final getDeputiesUseCase = GetDeputiesUseCase(getDeputiesRepository);
    final getDeputyRepository = GetDeputyRepositoryImpl(deputiesApi);
    final getDeputyUseCase = GetDeputyUseCase(getDeputyRepository);


    final parliamentClubsApi = ParliamentClubsApi(client);
    final getParliamentClubsRepository = GetParliamentClubsRepositoryImpl(parliamentClubsApi);
    final getParliamentClubsUseCase = GetParliamentClubsUseCase(getParliamentClubsRepository);



    return List<SingleChildWidget>.of([
      Provider<SimpleDioClient>(
        create: (_) => SimpleDioClient(client),
        dispose: (context, client) => client.dispose(),
      ),
      Provider<DeputiesCache>(
        create: (_) => DeputiesCache(getDeputiesUseCase, getParliamentClubsUseCase, getDeputyUseCase),
      )
    ]);
  }
}
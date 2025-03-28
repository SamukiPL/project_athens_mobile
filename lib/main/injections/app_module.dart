import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/auth/auth_repository_impl.dart';
import 'package:project_athens/athens_core/auth/network/auth_api.dart';
import 'package:project_athens/athens_core/chopper/auth_facade.dart';
import 'package:project_athens/athens_core/chopper/authenticated_dio_client.dart';
import 'package:project_athens/athens_core/chopper/auth_interceptor.dart';
import 'package:project_athens/athens_core/chopper/error_interceptor.dart';
import 'package:project_athens/athens_core/chopper/simple_dio_client.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/dashboard_flow/cache/parliament_meeting_cache.dart';
import 'package:project_athens/dashboard_flow/data/network/dashboard_api.dart';
import 'package:project_athens/dashboard_flow/data/parliament_meeting_details_repository_impl.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_details/get_parliament_meeting_details_use_case.dart';
import 'package:project_athens/dashboard_flow/mappers/parliament_meeting_details_network_mapper.dart';
import 'package:project_athens/deputies_utils/cache/deputies_cache.dart';
import 'package:project_athens/deputies_utils/cache/parliament_clubs_cache.dart';
import 'package:project_athens/deputies_utils/data/get_deputies_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/get_deputy_nouns_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/get_deputy_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/get_parliament_clubs_repository_impl.dart';
import 'package:project_athens/deputies_utils/data/network/deputies_api.dart';
import 'package:project_athens/deputies_utils/data/network/parliament_clubs_api.dart';
import 'package:project_athens/deputies_utils/domain/get_deputies/get_deputies_use_case.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy/get_deputy_use_case.dart';
import 'package:project_athens/deputies_utils/domain/get_deputy_nouns/get_deputy_nouns_use_case.dart';
import 'package:project_athens/deputies_utils/domain/get_parliament_clubs/get_parliament_clubs_use_case.dart';
import 'package:project_athens/speeches_flow/data/speech_cache.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppModule extends Module {
  AppModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final clientOptions = BaseOptions(
        baseUrl: "https://api.swiadoma-demokracja.pl",
        connectTimeout: 2 * 60 * 1000, // 2 minutes,
        receiveTimeout: 2 * 60 * 1000 // 2 minutes
        // uncomment this for local service connection.
        // baseUrl: "http://10.0.2.2:3505",
        );
    final client = Dio(clientOptions);

    final authenticatedClient = Dio(clientOptions);

    final baseInterceptors = [
      LogInterceptor(requestBody: true, responseBody: true),
      ErrorInterceptor()
    ];

    client.interceptors.addAll(baseInterceptors);

    final authApi = AuthApi(client);
    final authRepository = AuthRepositoryImpl(authApi);
    final authFacade = AuthFacade(authRepository);

    authenticatedClient.interceptors
        .addAll(baseInterceptors + [AuthInterceptor(authFacade)]);

    final clubsCache = _createClubsCache(authenticatedClient);

    return List<SingleChildWidget>.of([
      Provider<AuthFacade>.value(value: authFacade),
      Provider<SimpleDioClient>(
        create: (_) => SimpleDioClient(client),
        dispose: (context, client) => client.dispose(),
      ),
      Provider<AuthenticatedDioClient>(
          create: (_) => AuthenticatedDioClient(authenticatedClient),
          dispose: (context, client) => client.dispose()),
      Provider<ParliamentClubsCache>.value(value: clubsCache),
      Provider<DeputiesCache>(
        create: (_) => _createDeputiesCache(authenticatedClient, clubsCache),
      ),
      Provider<SpeechCache>(create: (_) => SpeechCache()),
      Provider<ParliamentMeetingCache>(
        create: (_) => _createParliamentMeetingCache(authenticatedClient),
        dispose: (_, cache) => cache.dispose(),
      )
    ]);
  }

  ParliamentMeetingCache _createParliamentMeetingCache(Dio client) {
    final dashboardApi = DashboardApi(client);
    final networkMapper = ParliamentMeetingNetworkMapper();
    final getParliamentMeetingRepository =
        ParliamentMeetingDetailsRepositoryImpl(dashboardApi, networkMapper);
    final useCase =
        GetParliamentMeetingDetailsUseCase(getParliamentMeetingRepository);

    return ParliamentMeetingCache(useCase);
  }

  ParliamentClubsCache _createClubsCache(Dio client) {
    final parliamentClubsApi = ParliamentClubsApi(client);
    final getParliamentClubsRepository =
        GetParliamentClubsRepositoryImpl(parliamentClubsApi);
    final getParliamentClubsUseCase =
        GetParliamentClubsUseCase(getParliamentClubsRepository);

    return ParliamentClubsCache(getParliamentClubsUseCase);
  }

  DeputiesCache _createDeputiesCache(
      Dio client, ParliamentClubsCache clubsCache) {
    final deputiesApi = DeputiesApi(client);
    final getDeputiesRepository =
        GetDeputiesRepositoryImpl(deputiesApi, clubsCache);
    final getDeputiesUseCase = GetDeputiesUseCase(getDeputiesRepository);
    final getDeputyRepository =
        GetDeputyRepositoryImpl(deputiesApi, clubsCache);
    final getDeputyUseCase = GetDeputyUseCase(getDeputyRepository);
    final getDeputyNounsRepository = GetDeputyNounsRepositoryImpl(deputiesApi);
    final getDeputyNounsUseCase =
        GetDeputyNounsUseCase(getDeputyNounsRepository);

    return DeputiesCache(
        getDeputiesUseCase, getDeputyUseCase, getDeputyNounsUseCase);
  }
}

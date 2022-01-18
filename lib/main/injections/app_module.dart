import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/chopper/error_interceptor.dart';
import 'package:project_athens/athens_core/chopper/network_module.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/utils/life_cycle_manager/life_cycle_service.dart';
import 'package:project_athens/athens_core/utils/notifications_service.dart';
import 'package:project_athens/dashboard_flow/cache/parliament_meeting_cache.dart';
import 'package:project_athens/dashboard_flow/data/network/dashboard_api.dart';
import 'package:project_athens/dashboard_flow/data/parliament_meeting_details_repository_impl.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_details/get_parliament_meeting_details_use_case.dart';
import 'package:project_athens/dashboard_flow/mappers/parliament_meeting_details_network_mapper.dart';
import 'package:project_athens/deputies_utils/cache/cache_errors.dart';
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
  AppModule(BuildContext context, this.lifeCycle) : super(context);

  final LifeCycleService lifeCycle;

  @override
  List<SingleChildWidget> getProviders() {
    final clientOptions = BaseOptions(
      baseUrl: "https://api.swiadoma-demokracja.pl",
    );
    final client = Dio(clientOptions);

    client.interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
      ErrorInterceptor()
    ]);

    final clubsCache = _createClubsCache(client);

    return List<SingleChildWidget>.of([
      Provider<SimpleDioClient>(
        create: (_) => SimpleDioClient(client),
        dispose: (context, client) => client.dispose(),
      ),
      Provider<LifeCycleService>.value(value: lifeCycle),
      Provider<ParliamentClubsCache>.value(
          value: clubsCache
      ),
      Provider<DeputiesCache>(
        create: (_) => _createDeputiesCache(client, clubsCache),
      ),
      Provider<SpeechCache>(create: (_) => SpeechCache()),
      Provider<ParliamentMeetingCache>(
        create: (_) => _createParliamentMeetingCache(client),
        dispose: (_, cache) => cache.dispose(),
      )
    ]);
  }

  ParliamentMeetingCache _createParliamentMeetingCache(Dio client) {
    final dashboardApi = DashboardApi(client);
    final networkMapper = ParliamentMeetingNetworkMapper();
    final getParliamentMeetingRepository = ParliamentMeetingDetailsRepositoryImpl(dashboardApi, networkMapper);
    final useCase = GetParliamentMeetingDetailsUseCase(getParliamentMeetingRepository);

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

  DeputiesCache _createDeputiesCache(Dio client, ParliamentClubsCache clubsCache) {
    final deputiesApi = DeputiesApi(client);
    final getDeputiesRepository = GetDeputiesRepositoryImpl(deputiesApi, clubsCache);
    final getDeputiesUseCase = GetDeputiesUseCase(getDeputiesRepository);
    final getDeputyRepository = GetDeputyRepositoryImpl(deputiesApi, clubsCache);
    final getDeputyUseCase = GetDeputyUseCase(getDeputyRepository);
    final getDeputyNounsRepository = GetDeputyNounsRepositoryImpl(deputiesApi);
    final getDeputyNounsUseCase = GetDeputyNounsUseCase(getDeputyNounsRepository);

    return DeputiesCache(getDeputiesUseCase, getDeputyUseCase, getDeputyNounsUseCase);
  }
}

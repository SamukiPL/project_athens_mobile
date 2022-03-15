import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/dashboard_flow/cache/dashboard_tiles_data_cache.dart';
import 'package:project_athens/dashboard_flow/data/dashboard_repository_impl.dart';
import 'package:project_athens/dashboard_flow/data/network/dashboard_api.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard/get_dashboard_use_case.dart';
import 'package:project_athens/dashboard_flow/mappers/dashobard_tiles_data_mapper.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/dashboard_bloc.dart';
import 'package:project_athens/dashboard_flow/screens/dashboard/tiles/nearest_meeting_tile/nearest_meeting_tile_bloc.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class DashboardModule extends Module {
  DashboardModule(BuildContext context) : super(context);

  @override
  List<SingleChildWidget> getProviders() {
    final AppLocalizations _localizations =
        Provider.of<AppLocalizations>(context);
    final _dio = Provider.of<Dio>(context);

    final DashboardApi dashboardApi = DashboardApi(_dio);
    final DashboardRepositoryImpl dashboardRepository =
        DashboardRepositoryImpl(dashboardApi);
    final GetDashboardUseCase getDashboardUseCase =
        GetDashboardUseCase(dashboardRepository);
    final SubscribedDeputiesCache _subscribedDeputiesCache =
        Provider.of<SubscribedDeputiesCache>(context);
    final DashboardTilesDataMapper _mapper =
        DashboardTilesDataMapper(_subscribedDeputiesCache);

    final DashboardTilesDataCache _dashboardCache =
        DashboardTilesDataCache(getDashboardUseCase, _mapper);

    return [
      Provider<DashboardBloc>(
          create: (context) =>
              DashboardBloc(_subscribedDeputiesCache, _dashboardCache),
          dispose: (context, bloc) => bloc.dispose()),
      Provider<DashboardTilesDataCache>.value(
        value: _dashboardCache,
      ),
      Provider<NearestMeetingTileBloc>(
          create: (context) =>
              NearestMeetingTileBloc(_dashboardCache, _localizations),
          dispose: (context, bloc) => bloc.dispose()),
    ];
  }
}

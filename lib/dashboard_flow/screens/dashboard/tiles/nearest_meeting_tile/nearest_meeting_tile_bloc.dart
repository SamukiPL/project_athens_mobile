import 'dart:async';

import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/date_time_extension.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/grid/tiles/simple_tile/simple_tile_bloc.dart';
import 'package:project_athens/dashboard_flow/cache/dashboard_tiles_data_cache.dart';
import 'package:project_athens/dashboard_flow/data/network/response/dashboard_response.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard/dashboard_tiles_data_model.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard/get_dashboard_use_case.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_params.dart';
import 'package:project_athens/timeline_flow/domain/meetings_date.dart';
import 'package:project_athens/timeline_flow/domain/timeline_parameters.dart';
import 'package:project_athens/timeline_flow/domain/use_cases/get_meetings_dates.dart';
import 'package:rxdart/rxdart.dart';

class NearestMeetingTileBloc extends SimpleTileBloc {

  final DashboardTilesDataCache _dashboardCache;
  final AppLocalizations _localizations;

  @override
  BehaviorSubject<DataLoadingState> loadingStateSource = BehaviorSubject<DataLoadingState>.seeded(DataLoadingState.initialLoading());

  NearestMeetingTileBloc(this._dashboardCache, this._localizations);

  Stream<String> get nearestMeetingTextStream => _dashboardCache.nearestMeetingStream.map((nearestMeetingResponse) {
    if (nearestMeetingResponse == null) return "";

    final today = DateTime.now();
    final todayBeginDay =
      DateTime(today.year, today.month, today.day, 0, 0, 0, 0);
    final closestDateTime =
      todayBeginDay.getClosestDate([nearestMeetingResponse.nearestPastMeeting]);

    bool isToday = closestDateTime.isToday;
    bool isYesterday = closestDateTime.isYesterday;

    hideLoader();

    if (closestDateTime.isToday) {
      return _localizations.getText().dashboardTilesNearestMeetingTileMeetingIsToday();
    } else if (closestDateTime.isYesterday) {
      return _localizations.getText().dashboardTilesNearestMeetingTileMeetingWasYesterday();
    } else if (closestDateTime.isTomorrow) {
      return _localizations.getText().dashboardTilesNearestMeetingTileMeetingIsTomorrow();
    } else {
      final howManyDaysToGo = today.getDaysBetween(closestDateTime);

      return ''
          + _localizations.getText().dashboardTilesNearestMeetingTileMeetingInDays()
          + ' '
          + howManyDaysToGo.toString()
          + ' '
          + _localizations.getText().dashboardTilesNearestMeetingTileDays();
    }
  }).handleError((onError) {
    Fimber.e(onError.toString());
  });

  void dispose() {
    super.dispose();
  }
}
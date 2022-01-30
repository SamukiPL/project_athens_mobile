import 'dart:async';

import 'package:project_athens/dashboard_flow/domain/dashboard/dashboard_tiles_data_model.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard/get_dashboard_use_case.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_params.dart';
import 'package:project_athens/dashboard_flow/mappers/dashobard_tiles_data_mapper.dart';
import 'package:rxdart/rxdart.dart';

class DashboardTilesDataCache {
  final GetDashboardUseCase _getDashboardUseCase;
  final DashboardTilesDataMapper _mapper;


  DashboardTilesDataCache(this._getDashboardUseCase, this._mapper) {
    _autoRefreshSub = Rx
        .timer(null, Duration(minutes: 10))
        .listen((event) => markDirtyParam(DashboardParams.fetchAll(9)));

    Rx.combineLatest2(
      _dirtyParamsSource,
      _forceRefreshSource.startWith(null),
      (params, forceRefresh) => params as DashboardParams
    ).debounceTime(Duration(milliseconds: 500))
        .listen((DashboardParams dirtyParams) => _fetchDashboard(dirtyParams));
  }

  final BehaviorSubject<DashboardTilesDataModel?> _dashboardTilesDataSource = BehaviorSubject<DashboardTilesDataModel?>.seeded(null);
  final ReplaySubject<void> _forceRefreshSource = ReplaySubject<void>();

  Stream<DashboardNearestMeetingTileDataModel?> get nearestMeetingStream => _dashboardTilesDataSource.map((event) => event?.nearestMeeting);
  Stream<DashboardSimpleDeputiesCounter?> get absentVoteStream => _dashboardTilesDataSource.map((event) => event?.absentVote);
  Stream<DashboardSimpleDeputiesCounter?> get speechesCounterStream => _dashboardTilesDataSource.map((event) => event?.speechesCounter);
  Stream<DashboardSimpleDeputiesCounterPerYearDataModel?> get absentVotePerYearStream => _dashboardTilesDataSource.map((event) => event?.absentVotePerYear);
  Stream<DashboardSimpleDeputiesCounterPerYearDataModel?> get speechesCounterPerYearStream => _dashboardTilesDataSource.map((event) => event?.speechesCounterPerYear);

  late StreamSubscription _autoRefreshSub;

  final BehaviorSubject<DashboardParams> _dirtyParamsSource = BehaviorSubject<DashboardParams>.seeded(
    DashboardParams(
      cadence: 9,
      meeting: true,
      monthMeetings: true,
      speechesCounter: true,
      speechesCounterPerYear: true,
      voteAbsent: true,
      voteAbsentPerYear: true
    )
  );
  final PublishSubject<bool> _fetchingFinished = PublishSubject();

  markDirtyParam(DashboardParams dirtyParams) {
    final currentDirtyParams = _dirtyParamsSource.value;

    if (dirtyParams.meeting == true) currentDirtyParams.meeting = true;
    if (dirtyParams.monthMeetings == true) currentDirtyParams.monthMeetings = true;
    if (dirtyParams.speechesCounter == true) currentDirtyParams.speechesCounter = true;
    if (dirtyParams.speechesCounterPerYear == true) currentDirtyParams.speechesCounterPerYear = true;
    if (dirtyParams.voteAbsent == true) currentDirtyParams.voteAbsent = true;
    if (dirtyParams.voteAbsentPerYear == true) currentDirtyParams.voteAbsentPerYear = true;

    _dirtyParamsSource.add(dirtyParams);
  }

  Future<bool?> forceRefresh() {
    markDirtyParam(DashboardParams.fetchAll(9));
    _forceRefreshSource.add(null);

    return _fetchingFinished.stream.first;
  }

  void _fetchDashboard(DashboardParams dirtyParams) async {
    if (!dirtyParams.isAnyDirty()) { return; }

    final result = await _getDashboardUseCase(dirtyParams);

    _fetchingFinished.add(true);

    if (result.isSuccess()) {
       final dashboardTilesData = await _mapper.transform(result.toSuccess().value);
       _dashboardTilesDataSource.add(dashboardTilesData);

       _dirtyParamsSource.add(DashboardParams.allPristine(cadence: 9));
    }
  }

  void dispose() {
    _forceRefreshSource.close();
    _dirtyParamsSource.close();
    _dashboardTilesDataSource.close();
    _autoRefreshSub.cancel();
    _fetchingFinished.close();
  }
}
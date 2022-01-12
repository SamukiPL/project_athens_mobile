import 'dart:async';

import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/dashboard_flow/data/network/response/dashboard_response.dart';
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

    _dirtyParamsSource.listen((dirtyParams) => _fetchDashboard(dirtyParams));
    Rx.combineLatest2(
      _dirtyParamsSource,
      _forceRefreshSource,
      (params, forceRefresh) => params as DashboardParams
    ).debounceTime(Duration(milliseconds: 500))
        .listen((DashboardParams dirtyParams) => _fetchDashboard(dirtyParams));
  }

  Stream<DashboardNearestMeetingTileDataModel?> get nearestMeetingStream => _dashboardTilesDataSource.map((event) => event?.nearestMeeting);
  Stream<DashboardSimpleDeputiesCounter?> get absentVoteStream => _dashboardTilesDataSource.map((event) => event?.absentVote);
  Stream<DashboardSimpleDeputiesCounter?> get speechesCounterStream => _dashboardTilesDataSource.map((event) => event?.speechesCounter);
  Stream<DashboardSimpleDeputiesCounterPerYearDataModel?> get absentVotePerYearStream => _dashboardTilesDataSource.map((event) => event?.absentVotePerYear);
  Stream<DashboardSimpleDeputiesCounterPerYearDataModel?> get speechesCounterPerYearStream => _dashboardTilesDataSource.map((event) => event?.speechesCounterPerYear);

  DashboardParams? _lastReqParams;

  late StreamSubscription _autoRefreshSub;
  final BehaviorSubject<DashboardTilesDataModel?> _dashboardTilesDataSource = BehaviorSubject<DashboardTilesDataModel?>.seeded(null);
  final ReplaySubject<void> _forceRefreshSource = ReplaySubject<void>();
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

    if (dirtyParams.meeting != null && dirtyParams.meeting == true) currentDirtyParams.meeting = true;
    if (dirtyParams.monthMeetings != null && dirtyParams.monthMeetings == true) currentDirtyParams.monthMeetings = true;
    if (dirtyParams.speechesCounter != null && dirtyParams.speechesCounter == true) currentDirtyParams.speechesCounter = true;
    if (dirtyParams.speechesCounterPerYear != null && dirtyParams.speechesCounterPerYear == true) currentDirtyParams.speechesCounterPerYear = true;
    if (dirtyParams.voteAbsent != null && dirtyParams.voteAbsent == true) currentDirtyParams.voteAbsent = true;
    if (dirtyParams.voteAbsentPerYear != null && dirtyParams.voteAbsentPerYear == true) currentDirtyParams.voteAbsentPerYear = true;

    _dirtyParamsSource.add(dirtyParams);
  }

  Future<bool?> forceRefresh() {
    markDirtyParam(DashboardParams.fetchAll(9));
    _forceRefreshSource.add(null);

    return _fetchingFinished.stream.first;
  }

  _fetchDashboard(DashboardParams dirtyParams) async {
    print(dirtyParams.toString());
    print(dirtyParams.isAnyDirty());

    if (!dirtyParams.isAnyDirty()) { return; }

    final result = await _getDashboardUseCase(dirtyParams);

    _fetchingFinished.add(true);

    if (result is Success<DashboardResponse>) {
       final dashboardTilesData = await _mapper.transform(result.value);
       _dashboardTilesDataSource.add(dashboardTilesData);

       _dirtyParamsSource.value.resetParams();
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
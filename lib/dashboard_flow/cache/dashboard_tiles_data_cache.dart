import 'package:project_athens/dashboard_flow/domain/dashboard/get_dashboard_use_case.dart';
import 'package:project_athens/dashboard_flow/domain/dashboard_params.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:rxdart/rxdart.dart';

class DashboardTilesDataCache {
  final GetDashboardUseCase _getDashboardUseCase;
  final SubscribedDeputiesCache _subscribedDeputiesCache;

  DashboardTilesDataCache(this._getDashboardUseCase, this._subscribedDeputiesCache);

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

  

  void dispose() {
    _dirtyParamsSource.close();
  }
}
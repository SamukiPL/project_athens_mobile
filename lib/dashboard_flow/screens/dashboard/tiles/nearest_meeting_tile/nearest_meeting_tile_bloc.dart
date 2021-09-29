import 'dart:async';

import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/ext/date_time_extension.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/timeline_flow/domain/meetings_date.dart';
import 'package:project_athens/timeline_flow/domain/timeline_parameters.dart';
import 'package:project_athens/timeline_flow/domain/use_cases/get_meetings_dates.dart';
import 'package:rxdart/rxdart.dart';

class NearestMeetingTileBloc extends BaseBloc {

  final GetMeetingsDates _getMeetingsDates;
  final AppLocalizations _localizations;
  late StreamSubscription periodicMeetingFetchSubscription;

  NearestMeetingTileBloc(this._getMeetingsDates, this._localizations) {
    periodicMeetingFetchSubscription =
        Rx
            .timer(null, Duration(minutes: 30))
            .startWith(null)
            .switchMap((event) =>
              _getMeetingsDates(TimelineParameters(9, DateTime.now().toIso8601String()))
                  .asStream()
                  .map((event) {
                     if (event is Success) {
                       return (event as Success<List<MeetingDate>>).value;
                     } else {
                       return List.empty();
                     }
            }))
            .map((event) => meetingDatesStream.add(event as List<MeetingDate>))
            .listen((event) { });
  }

  BehaviorSubject<List<MeetingDate>> meetingDatesStream = BehaviorSubject.seeded(List.empty());

  Stream<String> get nearestMeetingTextStream => meetingDatesStream.map((dates) {
    if (dates.length == 0) return "";

    final today = DateTime.now();
    final todayBeginDay =
      DateTime(today.year, today.month, today.day, 0, 0, 0, 0);
    final closestDateTime =
      todayBeginDay.getClosestDate(dates.map((e) => e.meetingDate).toList());

    bool isToday = closestDateTime.isToday;
    bool isYesterday = closestDateTime.isYesterday;

    if (closestDateTime.isToday) {
      return _localizations.getText().dashboardTilesNearestMeetingTileMeetingIsToday();
    } else if (closestDateTime.isYesterday) {
      return _localizations.getText().dashboardTilesNearestMeetingTileMeetingWasYesterday();
    } else if (closestDateTime.isTomorrow) {
      return _localizations.getText().dashboardTilesNearestMeetingTileMeetingIsTomorrow();
    } else {
      final howManyDaysToGo = today.getDaysBetween(closestDateTime);

      return _localizations.getText().dashboardTilesNearestMeetingTileMeetingInDays()
          + ' '
          + howManyDaysToGo.toString()
          + ' '
          + _localizations.getText().dashboardTilesNearestMeetingTileDays();
    }
  }).handleError((onError) {
    Fimber.e(onError.toString());
  });

  void dispose() {
    meetingDatesStream.close();
    periodicMeetingFetchSubscription.cancel();

    super.dispose();
  }
}
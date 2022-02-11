import 'dart:async';

import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/pagination/paging_bloc.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';
import 'package:project_athens/timeline_flow/domain/meetings_date.dart';
import 'package:project_athens/timeline_flow/domain/timeline_parameters.dart';
import 'package:project_athens/timeline_flow/domain/use_cases/get_meetings_dates.dart';
import 'package:project_athens/timeline_flow/domain/use_cases/get_timeline_use_case.dart';
import 'package:project_athens/timeline_flow/presentation/calendar_app_bar_bloc.dart';
import 'package:project_athens/timeline_flow/screens/timeline/cloud/noun_cloud_bloc.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model_factory.dart';

class TimelineBloc extends BaseBloc implements PagingBloc {

  final GetTimelineUseCase _getTimelineUseCase;

  final GetMeetingsDates _getMeetingsDates;

  final NounCloudBloc nounCloudBloc;

  TimelineBloc(this._getTimelineUseCase, this._getMeetingsDates, this.nounCloudBloc) {
    adapter = PagingListAdapter(this);
    _loadMeetingsDates();
  }

  @override
  late PagingListAdapter adapter;

  @override
  late int batchSize;

  @override
  late int offset;

  List<MeetingDate>? _dates;
  late DateTime _selectedDate;

  List<MeetingDate> get dates => _dates!;
  DateTime get selectedDate => _selectedDate;

  final CalendarAppBarBloc calendarBloc = CalendarAppBarBloc(DateTime.now());

  @override
  Future<void> loadMore() async {}

  @override
  Future<void> refresh() {
    if (_dates == null) {
      return _loadMeetingsDates();
    } else {
      adapter.updateList([]);
      return loadNewDate(_selectedDate);
    }
  }

  Future<void> _loadMeetingsDates() async {
    final result = await _getMeetingsDates(TimelineParameters(""));

    if (result is Success<List<MeetingDate>>) {
      _dates = result.value;
      loadNewDate(_getBeforeDate(DateTime.now()));
    } else {
      manageState(result);
    }
  }

  Future<void> loadNewDate(DateTime date) async {
    setLoadingState(DataLoadingState.initialLoading());
    final params = TimelineParameters(date.toIso8601String());
    adapter.updateList([], loading: true);
    _selectedDate = date;
    calendarBloc.setDate(date);
    nounCloudBloc.loadCloud(params);
    final result = await _getTimelineUseCase(params);

    if (result is Success<List<TimelineModel>>) {
      final items = result.value.toTimelineRowViewModel(
          date: date, timerViewModel: TimerViewModel(refresh), firstLevel: true);
      adapter.updateList(items);
      setLoadingState((items.isEmpty) ? DataLoadingState.noData() : DataLoadingState.contentLoaded());
    }
    manageState(result);

  }

  @override
  void dispose() {
    adapter.dispose();
    nounCloudBloc.dispose();
    super.dispose();
  }

  DateTime _getBeforeDate(DateTime referenceDate) {
    var dates = _dates!.toList();
    dates.sort((a, b) => a.meetingDate.compareTo(b.meetingDate));

    dates.retainWhere((element) => element.meetingDate.isBefore(referenceDate));
    return dates.last.meetingDate;
  }

  void setPreviousDate() {
    adapter.updateList([], loading: true);
    loadNewDate(_getBeforeDate(_selectedDate));
  }

  void setNextDate() {
    adapter.updateList([], loading: true);
    var dates = _dates!.toList();
    dates.sort((a, b) => a.meetingDate.compareTo(b.meetingDate));

    dates.retainWhere((element) => element.meetingDate.isAfter(_selectedDate));
    loadNewDate(dates.first.meetingDate);
  }

}
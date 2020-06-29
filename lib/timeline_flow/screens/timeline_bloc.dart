import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:project_athens/pagination/paging_bloc.dart';
import 'package:project_athens/pagination/paging_list_adapter.dart';
import 'package:project_athens/timeline_flow/domain/get_meetings_dates.dart';
import 'package:project_athens/timeline_flow/domain/get_timeline_use_case.dart';
import 'package:project_athens/timeline_flow/domain/meetings_date.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/domain/timeline_parameters.dart';
import 'package:project_athens/timeline_flow/presentation/calendar_app_bar_bloc.dart';
import 'package:project_athens/timeline_flow/screens/list/timeline_row_view_model.dart';
import 'package:project_athens/athens_core/domain/base_repository.dart';
import 'package:project_athens/timeline_flow/screens/list/timeline_row_view_model_factory.dart';

class TimelineBloc extends BaseBloc implements PagingBloc<TimelineRowViewModel> {

  final GetTimelineUseCase getTimelineUseCase;

  final GetMeetingsDates getMeetingsDates;

  TimelineBloc(this.getTimelineUseCase, this.getMeetingsDates) {
    adapter = PagingListAdapter(this);
    _loadMeetingsDates();
  }

  @override
  PagingListAdapter<TimelineRowViewModel> adapter;

  @override
  int batchSize;

  @override
  int page;

  List<MeetingDate> _dates;
  DateTime _selectedDate;

  List<TimelineRowViewModel> _items;

  List<MeetingDate> get dates => _dates;
  DateTime get selectedDate => _selectedDate;
  
  final CalendarAppBarBloc calendarBloc = CalendarAppBarBloc(DateTime.now());

  @override
  Future<void> loadMore() async {}

  @override
  Future<void> refresh() {
    adapter.updateList(List());
    return loadNewDate(_selectedDate);
  }

  Future<void> _loadMeetingsDates() async {
    final result = await getMeetingsDates(TimelineParameters(9, ""));

    if (result is Success<List<MeetingDate>>) {
      _dates = result.result;
      loadNewDate(_getBeforeDate(DateTime.now()));
    }
  }

  Future<void> loadNewDate(DateTime date) async {
    _selectedDate = date;
    calendarBloc.setDate(date);
    final result = await getTimelineUseCase(TimelineParameters(9, date.toIso8601String()));

    if (result is Success<List<TimelineModel>>) {
      _items = result.result.toTimelineRowViewModel();
      adapter.updateList(_items);
    }
  }

  @override
  void dispose() {
    adapter.dispose();
    super.dispose();
  }

  DateTime _getBeforeDate(DateTime referenceDate) {
    var dates = _dates;
    dates.sort((a, b) => a.meetingDate.compareTo(b.meetingDate));

    dates.retainWhere((element) => element.meetingDate.isBefore(referenceDate));
    return dates.last.meetingDate;
  }

  void setPreviousDate() {
    loadNewDate(_getBeforeDate(_selectedDate));
  }

  void setNextDate() {
    var dates = _dates;
    dates.sort((a, b) => a.meetingDate.compareTo(b.meetingDate));

    dates.retainWhere((element) => element.meetingDate.isAfter(_selectedDate));
    loadNewDate(dates.first.meetingDate);
  }

}
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_bloc.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_state.dart';
import 'package:project_athens/athens_core/presentation/widget_state.dart';
import 'package:project_athens/dashboard_flow/cache/parliament_meeting_cache.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_model.dart';

class NearestMeetingBloc extends BaseBloc {
  final ParliamentMeetingCache parliamentMeetingCache;
  final String _parliamentMeetingId;

  final DataLoadingBloc _dataLoadingBloc = DataLoadingBloc();

  ParliamentMeetingModel? _meetingModel;
  Failure? _fetchFailure;

  ParliamentMeetingModel get meetingModel => _meetingModel!;
  DataLoadingBloc get dataLoadingBloc => _dataLoadingBloc;

  NearestMeetingBloc(this.parliamentMeetingCache, this._parliamentMeetingId) {
    _fetchParliamentMeeting();
  }

  Future<void> _fetchParliamentMeeting() async {
    final result = await parliamentMeetingCache
        .getParliamentMeetingDetails(_parliamentMeetingId);

    if (result is Success) {
      _meetingModel = (result as Success<ParliamentMeetingModel>).value;
      _dataLoadingBloc.setDataLoadingState(DataLoadingState.contentLoaded());
    } else if (result is Failure) {
      _meetingModel = null;
      _fetchFailure = (result as Failure);
      dataLoadingBloc.setDataLoadingState(DataLoadingState.error(ErrorType.UNKNOWN));
    }
  }
}

import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_details/get_parliament_meeting_details_use_case.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_details_params.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_model.dart';
import 'package:project_athens/deputies_utils/cache/cache_errors.dart';

class ParliamentMeetingCache {
  final GetParliamentMeetingDetailsUseCase _meetingDetailsUseCase;

  ParliamentMeetingCache(this._meetingDetailsUseCase);

  final Map<String, Result<ParliamentMeetingModel>> _cachedParliamentMeeting = new Map<String, Result<ParliamentMeetingModel>>();
  final Map<String, Future<Result<ParliamentMeetingModel>>> _awaitingParliamentMeeting = new Map<String, Future<Result<ParliamentMeetingModel>>>();

  Future<Result<ParliamentMeetingModel>> getParliamentMeetingDetails(String parliamentMeetingId) async {
    if (_cachedParliamentMeeting.containsKey(parliamentMeetingId)) {
      return _cachedParliamentMeeting[parliamentMeetingId]!;
    }
    
    if (_awaitingParliamentMeeting.containsKey(parliamentMeetingId)) {
      return _awaitingParliamentMeeting[parliamentMeetingId]!;
    }
    
    return _fetchParliamentMeetingDetails(parliamentMeetingId);
  }
  
  Future<Result<ParliamentMeetingModel>> _fetchParliamentMeetingDetails(String parliamentMeetingId) async {
    final Future<Result<ParliamentMeetingModel>> _futureParliamentMeeting =
    _meetingDetailsUseCase(ParliamentMeetingDetailsParams(parliamentMeetingId, 9)).whenComplete(() {
      _awaitingParliamentMeeting.remove(parliamentMeetingId);
    }).then((parliamentMeetingResult) {
      if (parliamentMeetingResult is Success<ParliamentMeetingModel>) {
        parliamentMeetingResult.value.agenda.agendaPoints.sort((a, b) => a.orderPoint.compareTo(b.orderPoint));

        _cachedParliamentMeeting[parliamentMeetingId] = parliamentMeetingResult;
        return Success(parliamentMeetingResult.value);
      } else {
        return Failure(ParliamentMeetingCacheError(parliamentMeetingId));
      }
    });
    
    _awaitingParliamentMeeting[parliamentMeetingId] = _futureParliamentMeeting;
    
    return _futureParliamentMeeting;
  }

  void dispose() {
    _cachedParliamentMeeting.clear();
    _awaitingParliamentMeeting.clear();
  }
}

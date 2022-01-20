import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/dashboard_flow/cache/parliament_meeting_cache.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_model.dart';

class NearestMeetingBloc extends BaseBloc {
  final ParliamentMeetingCache parliamentMeetingCache;
  final String _parliamentMeetingId;

  NearestMeetingBloc(this.parliamentMeetingCache, this._parliamentMeetingId);

  Future<Result<ParliamentMeetingModel>> get parliamentMeeting =>
      parliamentMeetingCache.getParliamentMeetingDetails(_parliamentMeetingId);
}

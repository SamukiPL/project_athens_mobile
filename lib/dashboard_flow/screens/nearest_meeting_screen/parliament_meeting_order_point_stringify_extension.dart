import 'package:project_athens/dashboard_flow/domain/parliament_meeting_model.dart';

extension ParliamentMeetingOrderPointStringify on ParliamentMeetingAgendaPoint {
  get orderPointToString => orderPoint != 0
        ? "${orderPoint.toString()}. "
        : "";
}

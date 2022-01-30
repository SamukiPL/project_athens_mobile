import 'package:project_athens/dashboard_flow/domain/parliament_meeting_model.dart';

extension ParliamentMeetingFilteredAgendaPoints on List<ParliamentMeetingAgendaPoint> {
  List<ParliamentMeetingAgendaPoint> get plannedPoints =>
      this.where((element) => element.planned).toList();

  List<ParliamentMeetingAgendaPoint> get notPlannedPoints =>
      this.where((element) => !element.planned).toList();

  List<ParliamentMeetingAgendaPoint> get toBeSettledPoints =>
      this.where((element) => !element.active).toList();
}

extension ParliamentMeetingOrderPointStringify on ParliamentMeetingAgendaPoint {
  get orderPointToString => orderPoint != 0
        ? "${orderPoint.toString()}. "
        : "";

}


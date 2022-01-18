import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/dashboard_flow/data/network/response/parliament_meeting_details_response.dart';
import 'package:project_athens/dashboard_flow/domain/parliament_meeting_model.dart';

class ParliamentMeetingNetworkMapper extends DataMapper<ParliamentMeetingDetailsResponse, ParliamentMeetingModel> {
  ParliamentMeetingNetworkMapper();

  @override
  ParliamentMeetingModel transform(
      ParliamentMeetingDetailsResponse data) {
    final List<ParliamentMeetingAgendaPoint> agendaPoints = data.agenda.agendaPoints.map((point) =>
      new ParliamentMeetingAgendaPoint(
        point.agenda,
        point.tags,
        point.isUE,
        point.planned,
        point.active,
        point.orderPoint,
        point.createAt,
        point.updateAt,
        point.forms.map((form) =>
          new ParliamentMeetingAgendaPointForm(form.link, form.number, form.updateAt)).toList()
      )
    ).toList();

    return new ParliamentMeetingModel(
        data.date,
        data.cadence,
        data.isActive,
        data.id,
        data.sessionIId,
        new ParliamentMeetingAgenda(agendaPoints),
        data.createAt,
        data.updateAt
    );
  }
}

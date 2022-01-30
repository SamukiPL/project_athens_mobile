import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/models/db_harvest_model.dart';

class ParliamentMeetingModel extends DbHarvestModel {
  final DateTime date;
  final int cadence;
  final bool isActive;
  final String id;
  final int sessionIId;
  final ParliamentMeetingAgenda agenda;

  ParliamentMeetingModel(
      this.date,
      this.cadence,
      this.isActive,
      this.id,
      this.sessionIId,
      this.agenda,
      createAt,
      updateAt
    ) : super(createAt, updateAt);
}

class ParliamentMeetingAgenda {
  final List<ParliamentMeetingAgendaPoint> agendaPoints;

  ParliamentMeetingAgenda(this.agendaPoints);
}

class ParliamentMeetingAgendaPoint {
  final String agenda;
  final List<String> tags;
  final bool isUE;
  final bool planned;
  final bool active;
  final int orderPoint;
  final DateTime createAt;
  final DateTime updateAt;
  final List<ParliamentMeetingAgendaPointForm> forms;

  ParliamentMeetingAgendaPoint(this.agenda, this.tags, this.isUE, this.planned, this.active, this.orderPoint, this.createAt, this.updateAt, this.forms);
}

class ParliamentMeetingAgendaPointForm {
  final String link;
  final String number;
  final DateTime updateAt;

  ParliamentMeetingAgendaPointForm(this.link, this.number, this.updateAt);
}
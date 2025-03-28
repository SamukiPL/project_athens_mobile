import 'package:project_athens/athens_core/models/db_harvest_model.dart';
import 'package:project_athens/athens_core/models/timeline_voting_model.dart';

abstract class TimelineModel extends DbHarvestModel {

  final String id;
  final TimelineModelType type;
  final DateTime date;

  TimelineModel(this.id, this.type, this.date, DateTime? createAt, DateTime? updateAt) : super(createAt, updateAt);

}

class GroupedVotingModel extends TimelineModel {
  final String votingDesc;
  final String title;
  final List<TimelineVotingModel> groupedVotes;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? agenda;
  final int? orderPoint;

  GroupedVotingModel({
    required this.votingDesc,
    required this.title,
    required this.groupedVotes,
    required this.firstDate,
    required this.lastDate,
    required this.orderPoint,
    this.agenda,
    required String id,
    required DateTime date
  }) : super(id, TimelineModelType.GROUPED_VOTING, date, null, null);

}

class AdTimelineModel extends TimelineModel {
  AdTimelineModel() : super("ad", TimelineModelType.AD, DateTime.now(), null, null);
}

enum TimelineModelType { VOTING, GROUPED_VOTING, SPEECH, AD }

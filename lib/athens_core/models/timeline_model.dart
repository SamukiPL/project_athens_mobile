import 'dart:developer';

import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/models/db_harvest_model.dart';
import 'package:project_athens/athens_core/models/timeline_voting_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/deputies_utils/domain/parliament_club_model.dart';

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

  GroupedVotingModel({
    required this.votingDesc,
    required this.title,
    required this.groupedVotes,
    required this.firstDate,
    required this.lastDate,
    required String id,
    required DateTime date
  }) : super(id, TimelineModelType.GROUPED_VOTING, date, null, null);

}

enum TimelineModelType { VOTING, GROUPED_VOTING, SPEECH }

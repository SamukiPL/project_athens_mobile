import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';

abstract class TimelineRowViewModel extends BaseItemViewModel {

  final String id;
  final TimelineModelType type;

  TimelineRowViewModel(this.id, this.type);

}

class VotingRowViewModel extends TimelineRowViewModel {

  final String title;
  final DateTime date;
  final String votingDesc;

  VotingRowViewModel(String id, this.title, this.date, this.votingDesc) : super(id, TimelineModelType.VOTING);

}

class SpeechRowViewModel extends TimelineRowViewModel {

  final String title;
  final String desc;
  final DateTime date;
  final String thumbnailUrl;

  SpeechRowViewModel(String id, this.title, this.desc, this.date, this.thumbnailUrl) : super(id, TimelineModelType.SPEECH);

}
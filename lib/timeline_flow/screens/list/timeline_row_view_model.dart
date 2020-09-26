import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';

abstract class TimelineRowViewModel extends BaseItemViewModel {

  final TimelineModelType type;

  TimelineRowViewModel(this.type);

}

class VotingRowViewModel extends TimelineRowViewModel {

  final String title;
  final DateTime date;
  final String votingDesc;

  VotingRowViewModel(this.title, this.date, this.votingDesc) : super(TimelineModelType.VOTING);

}

class SpeechRowViewModel extends TimelineRowViewModel {

  final String title;
  final String desc;
  final DateTime date;
  final Future<String> thumbnailUrl;

  SpeechRowViewModel(this.title, this.desc, this.date, this.thumbnailUrl) : super(TimelineModelType.SPEECH);

}
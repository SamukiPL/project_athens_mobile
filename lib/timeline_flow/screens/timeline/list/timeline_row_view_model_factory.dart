import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/timeline_voting_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/ext/date_time_extension.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';

extension TimelineModelExtension on List<TimelineModel> {
  List<BaseItemViewModel> toTimelineRowViewModel(
      {DateTime? date, TimerViewModel? timerViewModel, bool firstLevel = false}) {
    final list = this.map((model) => _toRowViewModel(model, firstLevel)).toList();

    if (date != null && date.isToday) {
      list.add(timerViewModel!);
    }

    return list;
  }

  BaseItemViewModel _toRowViewModel(TimelineModel model, bool firstLevel) {
    BaseItemViewModel item;
    switch (model.type) {
      case TimelineModelType.VOTING:
        TimelineVotingModel votingModel = model as TimelineVotingModel;
        item = VotingRowViewModel(votingModel, firstLevel);
        break;
      case TimelineModelType.SPEECH:
        SpeechModel speechModel = model as SpeechModel;
        item = SpeechRowViewModel(speechModel);
        break;
      case TimelineModelType.GROUPED_VOTING:
        GroupedVotingModel groupedVotingModel = model as GroupedVotingModel;
        item = GroupedVotingViewModel(groupedVotingModel);
        break;
      default:
        throw Exception("There is no other type");
    }
    return item;
  }
}

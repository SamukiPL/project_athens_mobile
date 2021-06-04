import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/ext/date_time_extension.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';

extension DateHelpers on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return now.day == this.day &&
        now.month == this.month &&
        now.year == this.year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return yesterday.day == this.day &&
        yesterday.month == this.month &&
        yesterday.year == this.year;
  }
}

extension TimelineModelExtension on List<TimelineModel> {
  List<BaseItemViewModel> toTimelineRowViewModel(
      {DateTime date, TimerViewModel timerViewModel}) {
    final list = this.map((model) => _toRowViewModel(model)).toList();

    if (date != null && date.isToday) {
      list.add(timerViewModel);
    }

    return list;
  }

  BaseItemViewModel _toRowViewModel(TimelineModel model) {
    BaseItemViewModel item;
    switch (model.type) {
      case TimelineModelType.VOTING:
        VotingModel votingModel = model;
        item = VotingRowViewModel(votingModel);
        break;
      case TimelineModelType.SPEECH:
        SpeechModel speechModel = model;
        item = SpeechRowViewModel(speechModel);
        break;
      case TimelineModelType.GROUPED_VOTING:
        GroupedVotingModel groupedVotingModel = model;
        item = GroupedVotingViewModel(groupedVotingModel);
        break;
      default:
        throw Exception("There is no other type");
    }
    return item;
  }
}

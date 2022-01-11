import 'package:project_athens/athens_core/ext/date_time_extension.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/models/timeline_voting_model.dart';
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
    if (model is TimelineVotingModel) {
      return VotingRowViewModel(model, firstLevel);
    } else if (model is SpeechModel) {
      return SpeechRowViewModel(model);
    } else if (model is GroupedVotingModel) {
      return GroupedVotingViewModel(model);
    } else if (model is AdTimelineModel) {
      return AdTimelineViewModel();
    }

    throw Exception("There is no other type");
  }
}

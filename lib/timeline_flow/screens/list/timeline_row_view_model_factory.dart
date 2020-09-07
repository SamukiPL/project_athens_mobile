import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/screens/list/timeline_row_view_model.dart';

extension TimelineModelExtension on List<TimelineModel> {
  List<TimelineRowViewModel> toTimelineRowViewModel(void Function(TimelineModel) itemClick) {
    return this.map((model) => _toRowViewModel(model, itemClick)).toList();
  }

  TimelineRowViewModel _toRowViewModel(TimelineModel model, void Function(TimelineModel) itemClick) {
    switch (model.type) {
      case TimelineModelType.VOTING:
        VotingModel votingModel = model;
        return VotingRowViewModel(votingModel.title, votingModel.date);
        break;
      case TimelineModelType.SPEECH:
        SpeechModel speechModel = model;
        final item = SpeechRowViewModel(speechModel.title, speechModel.desc,
            speechModel.date, speechModel.thumbnailUrl);
        item.itemClick = () {
          itemClick.call(model);
        };
        return item;
        break;
      default:
        throw Exception("There is no other type");
    }
  }
}

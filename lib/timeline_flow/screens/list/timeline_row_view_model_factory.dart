import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/screens/list/timeline_row_view_model.dart';

extension TimelineModelExtension on List<TimelineModel> {

  List<TimelineRowViewModel> toTimelineRowViewModel() {
    return this.map((model) => TimelineRowViewModel(model.type, model.title, model.desc, model.date)).toList();
  }

}
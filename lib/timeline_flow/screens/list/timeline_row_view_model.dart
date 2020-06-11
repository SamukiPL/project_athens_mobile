import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/timeline_flow/data/network/response/timeline_response.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';

class TimelineRowViewModel extends BaseItemViewModel {

  final TimelineModelType type;
  final String title;
  final String desc;
  final DateTime date;

  TimelineRowViewModel(this.type, this.title, this.desc, this.date);


}
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';

class SpeechItemViewModel extends BaseItemViewModel {

  final String id;
  final String speakerName;
  final String desc;
  final String thumbnailUrl;

  SpeechItemViewModel(this.id, this.speakerName, this.desc, this.thumbnailUrl);

}
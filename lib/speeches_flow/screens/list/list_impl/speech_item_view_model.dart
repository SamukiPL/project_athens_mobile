import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';

class SpeechItemViewModel extends BaseItemViewModel {

  final String id;
  final String personName;
  final String desc;
  final String thumbnailUrl;
  final String date;

  SpeechItemViewModel(this.id, this.personName, this.desc, this.thumbnailUrl, this.date);

}
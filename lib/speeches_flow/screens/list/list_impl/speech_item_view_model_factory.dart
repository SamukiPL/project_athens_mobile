import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/domain/data_mapper.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speech_item_view_model.dart';

class SpeechItemViewModelFactory extends DataMapper<SpeechModel, SpeechItemViewModel> {
  @override
  SpeechItemViewModel transform(data) => SpeechItemViewModel(
    data.id,
    data.personName,
    data.desc,
    data.thumbnailUrl,
    DateFormat("d.M.y", "pl").format(data.date)
  );

}
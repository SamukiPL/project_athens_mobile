import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/item_view_model_factory.dart';
import 'package:project_athens/speeches_flow/screens/list/list_impl/speech_item_view_model.dart';

class SpeechItemViewModelFactory extends ItemViewModelFactory {

  @override
  BaseItemViewModel? createWithoutError(BaseModel model) {
    if (model is SpeechModel) {
      return SpeechItemViewModel(model);
    }

    return null;
  }
}

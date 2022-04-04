import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/item_view_model_factory.dart';
import 'package:project_athens/deputies_flow/screens/speeches_list/list_impl/deputy_speeches_list_item_view_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class DeputySpeechItemViewModelFactory extends ItemViewModelFactory {
  @override
  BaseItemViewModel? createWithoutError(BaseModel model) {
    if (model is SpeechModel) {
      return DeputySpeechListItemViewModel(model);
    }
    return null;
  }
}

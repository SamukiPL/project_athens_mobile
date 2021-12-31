import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/item_view_model_factory.dart';
import 'package:project_athens/deputies_flow/screens/list/list_impl/deputy_list_item_view_model.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class DeputyItemViewModelFactory extends ItemViewModelFactory {

  @override
  BaseItemViewModel? createWithoutError(BaseModel model) {
    if (model is DeputyModel) {
      return DeputyListItemViewModel(model: SubscribedDeputyModel.fromDeputyModel(model, false, "asdasdawds", SubscribedDeputyNotificationsNotifier(false, false, false, false)));
    }
    return null;
  }

}

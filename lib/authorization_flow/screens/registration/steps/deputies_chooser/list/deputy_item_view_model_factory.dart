import 'package:project_athens/authorization_flow/screens/registration/steps/deputies_chooser/list/deputy_item_view_model.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';

extension DeputyItemViewModelFactory on List<DeputyModel> {
  List<DeputyItemViewModel> toDeputyItemViewModels(
      bool Function(DeputyItemViewModel) itemClick) {
    return this.map((model) {
      var item = DeputyItemViewModel(model: model, name: model.name);
      item.itemClick = itemClick;
      return item;
    }).toList();
  }
}

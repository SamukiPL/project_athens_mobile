import 'package:authorization_flow/domain/deputies_registration/deputy_model.dart';
import 'package:authorization_flow/screens/deputies_registration/list/deputy_item_view_model.dart';

extension DeputyItemViewModelFactory on List<DeputyModel> {
  List<DeputyItemViewModel> toDeputyItemViewModels() {
    return this
        .map((model) => DeputyItemViewModel(
              name: model.name,
            ))
        .toList();
  }
}

import 'package:deputy_subscription/domain/deputies_registration/deputy_model.dart';
import 'package:deputy_subscription/presentation/deputies_registration/list/deputy_item_view_model.dart';

extension DeputyItemViewModelFactory on List<DeputyModel> {
  List<DeputyItemViewModel> toDeputyItemViewModels() {
    return this
        .map((model) => DeputyItemViewModel(
              firstName: model.firstName,
              lastName: model.lastName,
            ))
        .toList();
  }
}

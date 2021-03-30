import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';

abstract class ItemViewModelFactory {

  BaseItemViewModel create(BaseModel model) {
    final newItemViewModel = createWithoutError(model);
    if (newItemViewModel != null)
      return newItemViewModel;

    throw ArgumentError("Unsupported model for this factory");
  }

  BaseItemViewModel createWithoutError(BaseModel model);

}
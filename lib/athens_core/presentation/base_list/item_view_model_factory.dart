import 'package:project_athens/athens_core/ads/domain/ad_model.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_view_model.dart';
import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';

abstract class ItemViewModelFactory {

  BaseItemViewModel create(BaseModel model) {
    final newItemViewModel = createWithoutError(model);
    if (newItemViewModel != null) {
      return newItemViewModel;
    }  else if (model is AdModel) {
      return NativeAdViewModel();
    }

    throw ArgumentError("Unsupported model for this factory");
  }

  BaseItemViewModel? createWithoutError(BaseModel model);

}

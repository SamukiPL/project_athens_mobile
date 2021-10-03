import 'package:project_athens/athens_core/domain/base_list/base_model.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/items/easy_filter_item_view_model.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/updatable_easy_filter_item.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filter_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/base_list/item_view_model_factory.dart';

class EasyFilterItemViewModelFactory<T> extends ItemViewModelFactory {
  final Function(UpdatableEasyFilterItem<T>) _changeSelection;
  final Function _removeSelection;
  final bool Function(UpdatableEasyFilterItem<T> item) _isSelected;

  EasyFilterItemViewModelFactory(
      this._changeSelection, this._removeSelection, this._isSelected);

  @override
  BaseItemViewModel? createWithoutError(BaseModel model) {
    if (model is EasyFilterModel<T>) {
        return EasyFilterItemViewModel<T>(model,
            _changeSelection, _removeSelection, _isSelected);
    }
    return null;
  }
}

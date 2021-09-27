import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/items/easy_filter_item_view_model_factory.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/updatable_easy_filter_item.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filter_model.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filters_facade.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';

class EasyFiltersListBloc<T> extends BaseBloc {
  final EasyFiltersFacade _easyFiltersFacade;

  EasyFiltersListBloc(this._easyFiltersFacade) {
    _itemsFactory = EasyFilterItemViewModelFactory<T>(
        changeSelection, removeSelection, isSelected);
    _getItems();
  }

  late final EasyFilterItemViewModelFactory<T> _itemsFactory;

  List<BaseItemViewModel> _easyFiltersItems = List.empty();

  List<BaseItemViewModel> get easyFiltersItems => _easyFiltersItems;

  UpdatableEasyFilterItem? selectedItem;

  Future<void> _getItems() async {
    _easyFiltersFacade.getEasyFilters().then((result) {
      if (result is Success<List<EasyFilterModel<T>>>) {
        _easyFiltersItems =
            result.value.map((model) => _itemsFactory.create(model)).toList();
      }
      manageState(result);
    });
  }

  void changeSelection(UpdatableEasyFilterItem item) {
    final oldItem = selectedItem;
    selectedItem = item;
    selectedItem?.updateSelection();
    oldItem?.updateSelection();
    _easyFiltersFacade.changeFilterValue(item.getFilterValue());
  }

  void removeSelection() {
    final oldItem = selectedItem;
    selectedItem = null;
    oldItem?.updateSelection();
    _easyFiltersFacade.changeFilterValue(null);
  }

  bool isSelected(UpdatableEasyFilterItem item) => item == selectedItem;
}

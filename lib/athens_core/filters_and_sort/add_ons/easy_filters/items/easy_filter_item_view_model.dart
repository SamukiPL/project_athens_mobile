import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/items/easy_filter_view_holder.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/updatable_easy_filter_item.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/easy_filters/easy_filter_model.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';

class EasyFilterItemViewModel<T> extends BaseItemViewModel
    implements UpdatableEasyFilterItem<T> {
  final EasyFilterModel<T> _model;

  final Function(UpdatableEasyFilterItem<T>) _changeSelection;
  final Function _removeSelection;
  final bool Function(UpdatableEasyFilterItem<T>) _isSelected;

  EasyFilterItemViewModel(this._model, this._changeSelection,
      this._removeSelection, this._isSelected);

  bool get isSelected => _isSelected(this);

  String get title => _model.title;

  String? get iconUrl => _model.iconUrl;

  @override
  Widget buildWidget(int index, int length) =>
      EasyFilterViewHolder(this, index);

  void itemClicked() {
    if (isSelected) {
      _removeSelection();
    } else {
      _changeSelection(this);
    }
  }

  @override
  void updateSelection() {
    notifyListeners();
  }

  @override
  T getFilterValue() => _model.filterValue;
}

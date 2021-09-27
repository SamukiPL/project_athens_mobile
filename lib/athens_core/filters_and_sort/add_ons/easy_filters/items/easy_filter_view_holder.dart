
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/filters_and_sort/add_ons/easy_filters/items/easy_filter_item_view_model.dart';
import 'package:provider/provider.dart';

class EasyFilterViewHolder extends StatelessWidget {
  final EasyFilterItemViewModel _viewModel;
  final int index;

  const EasyFilterViewHolder(this._viewModel, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final leftPadding = (index == 0) ? 16.0 : 8.0;
    return ChangeNotifierProvider.value(
      value: _viewModel,
      child: Consumer<EasyFilterItemViewModel>(
        builder: (context, viewModel, _) => Container(
          padding: EdgeInsets.only(left: leftPadding),
          child: ChoiceChip(
            label: Text(_viewModel.title),
            selected: viewModel.isSelected,
            onSelected: (_) => _viewModel.itemClicked(),
          ),
        ),
      ),
    );
  }
}

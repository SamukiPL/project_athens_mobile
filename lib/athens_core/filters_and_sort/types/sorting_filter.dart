import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/filters_and_sort/domain/sorting_model.dart';
import 'package:project_athens/athens_core/filters_and_sort/types/base_filter_type.dart';
import 'package:provider/provider.dart';

class SortingFilter extends BaseFilterType {
  final List<SortingModel> sortings;
  
  SortingModel currentSort;

  SortingFilter(this.sortings) {
    currentSort = sortings.firstWhere((element) => element.isChosen) ?? sortings.first;
    _chosenId = currentSort.id;
  }

  int _chosenId;

  @override
  SortingFilter copy() => SortingFilter(sortings.map((e) => e.copy(_chosenId)).toList());

  @override
  Widget buildFilter(BuildContext parentContext) {
    return ChangeNotifierProvider<SortingFilter>.value(
      value: this,
      child: Consumer<SortingFilter>(
        builder: (context, type, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 8, top: 4),
              child: Text(
                "Sort by:",
                style: TextStyle(fontSize: 18),
              ),
            ),
            _getChoicesList(),
          ],
        ),
      ),
    );
  }

  Widget _getChoicesList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(sortings.length, (index) {
          final sort = sortings[index];
          return Container(
            margin: EdgeInsets.only(left: 8),
            child: ChoiceChip(
              label: Text(sort.title, style: TextStyle(fontSize: 18),),
              selected: _chosenId == sort.id,
              onSelected: (selected) {
                _chosenId = sort.id;
                notifyListeners();
              },
            ),
          );
        }),
      ),
    );
  }

}

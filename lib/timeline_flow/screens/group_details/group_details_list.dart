import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/athens_core/presentation/stateless_list_widget.dart';

class GroupDetailsList extends StatelessListWidget<BaseItemViewModel> {

  GroupDetailsList(List<BaseItemViewModel> items) : super(items);

  @override
  StatelessWidget getItemViewHolder(BaseItemViewModel item, int index, int length) {
    return item.buildWidget(index, length);
  }

}
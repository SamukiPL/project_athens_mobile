import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:project_athens/deputies_flow/screens/list/list_impl/view_holders/deputy_list_view_holder.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class DeputyListItemViewModel extends BaseItemViewModel {

  final SubscribedDeputyModel model;

  DeputyListItemViewModel({required this.model});

  @override
  Widget buildWidget(int index, int length) {
    return DeputyListViewHolder(viewModel: this);
  }

}
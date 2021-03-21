import 'package:project_athens/athens_core/presentation/base_item_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/deputy_subscription/presentation/deputies_registration/list/view_holders/deputy_view_holder.dart';

class DeputyItemViewModel extends BaseItemViewModel {

  final String firstName;

  final String lastName;

  DeputyItemViewModel({@required this.firstName, @required this.lastName});

  @override
  Widget buildWidget(int index, int length) {
    return DeputyViewHolder(viewModel: this);
  }

  @override
  void itemClick() {
    // TODO: implement itemClick
  }


}
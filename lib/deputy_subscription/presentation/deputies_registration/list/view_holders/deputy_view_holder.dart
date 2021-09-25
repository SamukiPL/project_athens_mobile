import 'package:project_athens/deputy_subscription/presentation/deputies_registration/list/deputy_item_view_model.dart';
import 'package:flutter/cupertino.dart';

class DeputyViewHolder extends StatelessWidget {

  final DeputyItemViewModel viewModel;

  const DeputyViewHolder({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(viewModel.firstName),
        Text(viewModel.lastName)
      ],
    );
  }

}
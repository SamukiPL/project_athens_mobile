import 'package:authorization_flow/screens/deputies_registration/list/deputy_item_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeputyViewHolder extends StatelessWidget {

  final DeputyItemViewModel viewModel;

  const DeputyViewHolder({Key key, @required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<DeputyItemViewModel>(
        builder: (context, viewModel, _) => CheckboxListTile(
          value: viewModel.checked,
          onChanged: (checked) => viewModel.setChecked(checked),
          title: Text(viewModel.name),
        ),
      ),
    );
  }

}
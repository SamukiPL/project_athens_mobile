import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model.dart';

class VoteViewHolder extends StatelessWidget {

  final VoteItemViewModel _viewModel;

  VoteViewHolder(this._viewModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _viewModel.itemClick();
      },
      child: Container(
        width: double.infinity,
        height: 300,
        color: Colors.red,
      ),
    );
  }

}
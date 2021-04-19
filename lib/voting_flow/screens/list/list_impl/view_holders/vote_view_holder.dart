import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model.dart';

class VoteViewHolder extends StatelessWidget with RedirectionDelegate {

  final VoteItemViewModel _viewModel;

  VoteViewHolder(this._viewModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        goToDestination(context, VoteDetailsDestination(_viewModel.model));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTypeAndDateRow(theme),
          _getResults(),
          _getTitle(theme),
          TechnicalData(technicalId: _viewModel.id),
          _getBorderBottom(theme),
        ],
      ),
    );
  }

  Widget _getTypeAndDateRow(ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _viewModel.description,
            style: TextStyle(
              color: theme.primaryColor,
              fontSize: 18
            ),
          ),
          Text(
            _viewModel.date,
            style: TextStyle(
                color: theme.dividerColor,
                fontSize: 12
            ),
          )
        ],
      ),
    );
  }

  Widget _getResults() {
    return Container(
      child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.black,
              fontSize: 14
            ),
            children: [
              TextSpan(text: _viewModel.results.inFavor.toString(), style: TextStyle(color: Colors.green)),
              TextSpan(text: "/",),
              TextSpan(text: _viewModel.results.against.toString(), style: TextStyle(color: Colors.red)),
              TextSpan(text: "/",),
              TextSpan(text: _viewModel.results.hold.toString(), style: TextStyle(color: Colors.grey)),
              TextSpan(text: "/",),
              TextSpan(text: _viewModel.results.absent.toString(), style: TextStyle(color: Colors.grey)),
            ]
          )
      ),
    );
  }

  Widget _getTitle(ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        _viewModel.title,
        style: TextStyle(
          color: theme.dividerColor,
            fontSize: 14
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _getBorderBottom(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.dividerColor,
      ),
      height: 1,
    );
  }

}
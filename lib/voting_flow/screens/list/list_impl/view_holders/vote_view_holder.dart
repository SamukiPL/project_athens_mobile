import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/presentation/item_was_seen/item_seen_state_holder.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/athens_core/presentation/vote_majority_distribution/vote_majority_distribution.dart';
import 'package:project_athens/athens_core/presentation/vote_majority_distribution/vote_majority_distribution_helper.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:project_athens/voting_flow/screens/list/list_impl/vote_item_view_model.dart';
import 'package:provider/provider.dart';

class VoteViewHolder extends StatelessWidget with RedirectionDelegate {

  final VoteItemViewModel _viewModel;

  VoteViewHolder(this._viewModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        goToDestination(context, VoteDetailsDestination(_viewModel.model));
        _viewModel.itemWasSeen();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTypeAndDateRow(theme),
          _getResults(),
          _getTitle(theme),
          _getVoteMajorityDistribution(),
          TechnicalData(technicalId: _viewModel.id),
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
          ChangeNotifierProvider<ItemSeenStateHolder>.value(
              value: _viewModel,
              child: Consumer<ItemSeenStateHolder>(
                builder: (_, model, child) => Text(
                  _viewModel.description,
                  style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: model.viewed ? FontWeight.normal : FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              )
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

  Widget _getVoteMajorityDistribution() {
    final models = voteMajorityDistrinutionFromVoteSlim(_viewModel.model.clubsMajority!, _viewModel.model.deputiesVote!, true);

    return VoteMajorityDistribution(votesMajority: models, showAbsent: true, showMiniatures: true);
  }

}

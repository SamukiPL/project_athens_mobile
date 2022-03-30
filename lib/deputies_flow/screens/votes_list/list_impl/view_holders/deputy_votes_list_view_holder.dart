import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/models/voting_model.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/presentation/item_was_seen/item_seen_state_holder.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/deputies_flow/screens/votes_list/list_impl/deputy_votes_list_item_view_model.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:provider/provider.dart';

class DeputyVotesListViewHolder extends StatelessWidget with RedirectionDelegate {
  final DeputyVotesListItemViewModel _viewModel;

  DeputyVotesListViewHolder(this._viewModel);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        goToDestination(context, VoteDetailsDestination(_viewModel.model), replaceBottomNavItem: false);
        _viewModel.itemWasSeen();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getTypeAndDateRow(theme),
          _getResults(theme),
          _getTitle(theme),
          TechnicalData(technicalId: _viewModel.model.id),
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
                  maxLines: 1,
                  style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: model.viewed ? FontWeight.normal : FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.left,
                ),
              )),
          Text(
            _viewModel.date,
            style: TextStyle(color: theme.dividerColor, fontSize: 12),
          )
        ],
      ),
    );
  }

  Widget _getDeputyVoteTypeIcons(ThemeData theme) {
    final containerize = (Icon icon) => Container(
          child: icon,
          margin: EdgeInsets.only(left: 6),
        );

    return Container(
      child: Row(
        children: [
          containerize(Icon(
            Icons.thumb_up,
            color: _viewModel.getVoteIconColor(theme, VoteType.IN_FAVOR),
            size: 15,
          )),
          containerize(Icon(
            Icons.thumb_down,
            color: _viewModel.getVoteIconColor(theme, VoteType.AGAINST),
            size: 15,
          )),
          containerize(Icon(
            Icons.pan_tool,
            color: _viewModel.getVoteIconColor(theme, VoteType.HOLD),
            size: 15,
          )),
          containerize(Icon(
            MdiIcons.accountOff,
            color: _viewModel.getVoteIconColor(theme, VoteType.ABSENT),
            size: 19,
          )),
        ],
      ),
    );
  }

  Widget _getResults(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: RichText(
              text: TextSpan(style: TextStyle(color: Colors.black, fontSize: 14), children: [
            TextSpan(text: _viewModel.model.voteNumbers.inFavor.toString(), style: TextStyle(color: Colors.green)),
            TextSpan(
              text: "/",
            ),
            TextSpan(text: _viewModel.model.voteNumbers.against.toString(), style: TextStyle(color: Colors.red)),
            TextSpan(
              text: "/",
            ),
            TextSpan(text: _viewModel.model.voteNumbers.hold.toString(), style: TextStyle(color: Colors.grey)),
            TextSpan(
              text: "/",
            ),
            TextSpan(text: _viewModel.model.voteNumbers.absent.toString(), style: TextStyle(color: Colors.grey)),
          ])),
        ),
        _getDeputyVoteTypeIcons(theme)
      ],
    );
  }

  Widget _getTitle(ThemeData theme) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        _viewModel.model.title,
        style: TextStyle(color: theme.dividerColor, fontSize: 14),
        textAlign: TextAlign.left,
      ),
    );
  }
}

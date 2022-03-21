import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/data/vote/vote_slim_model.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/presentation/item_was_seen/item_seen_state_holder.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/athens_core/presentation/vote_majority_distribution/vote_majority_distribution.dart';
import 'package:project_athens/athens_core/presentation/vote_majority_distribution/vote_majority_distribution_helper.dart';
import 'package:project_athens/timeline_flow/helpers/timeline_voting_agenda_helper.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
import 'package:provider/provider.dart';

class VotingViewHolder extends StatelessWidget with RedirectionDelegate {
  final VotingRowViewModel viewModel;
  final bool showTopLine;
  final bool showBottomLine;
  final bool firstLevel;

  const VotingViewHolder(this.viewModel, this.showTopLine, this.showBottomLine, {Key? key, this.firstLevel = false})
      : super(key: key);

  final double lineThickness = 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: <Widget>[
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            getHourWidget(context, theme),
            getIcon(context, theme),
            getRowText(context, theme)
          ],
        ),
      ),
    ]);
  }

  Widget getHourWidget(BuildContext context, ThemeData theme) {
    return Container(
      width: 60,
      margin: EdgeInsets.only(left: 4, right: 4),
      child: Center(
        child: Wrap(
          children: <Widget>[
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                DateFormat("HH:mm").format(viewModel.model.voteAt),
                style: TextStyle(
                    color: theme.dividerColor, fontSize: 24, fontWeight: FontWeight.w300),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getIcon(BuildContext context, ThemeData theme) {
    return Container(
      width: 60,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Column(children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Visibility(
                visible: showTopLine,
                child: VerticalDivider(
                    thickness: lineThickness, color: theme.dividerColor),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Visibility(
                visible: showBottomLine,
                child: VerticalDivider(
                    thickness: lineThickness, color: theme.dividerColor),
              ),
            ),
          ]),
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: theme.dividerColor, width: lineThickness)),
                child: Icon(
                    MdiIcons.vote,
                    color: theme.dividerColor,
                    size: 25,
                  ),
                ),
          ),
        ]
      ),
    );
  }

  List<Widget> _getFirstLevelRowTextContent(BuildContext context, ThemeData theme) {
    Widget agendaDesc = Container();

    final agendaWithoutExtras = getAgendaWithoutExtras(viewModel.model.agenda);
    if (agendaWithoutExtras != null) {
      agendaDesc = Container(
          width: double.infinity,
          child: Text(
            agendaWithoutExtras,
            style: TextStyle(
                color: theme.dividerColor, fontSize: 12),
            textAlign: TextAlign.left,
          )
      );
    }

    final String votingDesc = viewModel.model.orderPoint != null
        ? 'Pkt. ' + viewModel.model.orderPoint.toString() + ' - ' + viewModel.model.votingDesc
        : viewModel.model.votingDesc;

    final AppLocalizations _localizations = AppLocalizations.of(context)!;

    return [
      Container(
        width: double.infinity,
        child: Text(
          _localizations.getText().timelineVote(),
          style: theme.textTheme.overline?.copyWith(
              color: theme.dividerColor,
              fontSize: 10
          ),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        width: double.infinity,
        child: ChangeNotifierProvider<ItemSeenStateHolder>.value(
            value: viewModel,
            child: Consumer<ItemSeenStateHolder>(
              builder: (_, model, child) => Text(
                votingDesc,
                maxLines: 1,
                style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: model.viewed ? FontWeight.normal : FontWeight.bold,
                    fontSize: 16),
                textAlign: TextAlign.left,
              ),
            )
        ),
      ),
      Container(
          padding: EdgeInsets.only(top: 8),
          width: double.infinity,
          child: _getVoteDistributionMajority()
        ),
      agendaDesc,
      TechnicalData(technicalId: viewModel.model.id)
    ];
  }

  List<Widget> _getNestedLevelRowTextContent(BuildContext context, ThemeData theme) {
    final AppLocalizations _localizations = AppLocalizations.of(context)!;

    final String extras = getAgendaExtras(viewModel.model.agenda) ?? _localizations.getText().timelineVoteNoAgenda();

    return <Widget>[
      Container(
        width: double.infinity,
        child: Text(
          _localizations.getText().timelineVote(),
          style: theme.textTheme.overline?.copyWith(
              color: theme.dividerColor,
              fontSize: 10
          ),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        width: double.infinity,
        child: ChangeNotifierProvider<ItemSeenStateHolder>.value(
            value: viewModel,
            child: Consumer<ItemSeenStateHolder>(
              builder: (_, model, child) => Text(
                extras,
                maxLines: 1,
                style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: model.viewed ? FontWeight.normal : FontWeight.bold,
                    fontSize: 16),
                textAlign: TextAlign.left,
              ),
            )
        ),
      ),
      Container(
          padding: EdgeInsets.only(top: 8),
          width: double.infinity,
          child: _getVoteDistributionMajority()
      ),
      TechnicalData(technicalId: viewModel.model.id),
    ];
  }

  Widget getRowText(BuildContext context, ThemeData theme) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.only(left: 8, top: 8, bottom: 8,  right: 8),
        elevation: 4,
        child: InkWell(
          onTap: () {
            goToDestination(context, VoteDetailsDestination(
              VoteSlimModel.fromTimelineVotingModel(viewModel.model)
            ), replaceBottomNavItem: false);
            viewModel.itemWasSeen();

          },
          child: Container(
            margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Column(
              children: firstLevel 
                ? _getFirstLevelRowTextContent(context, theme)
                : _getNestedLevelRowTextContent(context, theme)
            ),
          ),
        ),
      ),
    );
  }

  Widget _getVoteDistributionMajority() {
    final models = voteMajorityDistrinutionFromVoteSlim(viewModel.model.clubsMajority, viewModel.model.deputiesVote, true);

    return VoteMajorityDistribution(votesMajority: models, showAbsent: true, showMiniatures: true);
  }
}

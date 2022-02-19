import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/athens_core/presentation/item_was_seen/item_seen_state_holder.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/timeline_flow/helpers/timeline_voting_agenda_helper.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destinations.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';
import 'package:provider/provider.dart';

class GroupedVotingViewHolder extends StatelessWidget with RedirectionDelegate {
  final GroupedVotingViewModel viewModel;
  final bool showTopLine;
  final bool showBottomLine;

  const GroupedVotingViewHolder(this.viewModel, this.showTopLine, this.showBottomLine, {Key? key})
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
                DateFormat("HH:mm").format(viewModel.model.firstDate),
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

  Widget getRowText(BuildContext context, ThemeData theme) {
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

    return Expanded(
      child: Card(
        margin: EdgeInsets.only(left: 8, top: 8, bottom: 8,  right: 8),
        elevation: 4,
        child: InkWell(
          onTap: () {
            goToDestination(context, GroupDetailsDestination(viewModel.model));
          },
          child: Container(
            margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                    )
                ),
                agendaDesc,
                TechnicalData(technicalId: viewModel.model.id),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

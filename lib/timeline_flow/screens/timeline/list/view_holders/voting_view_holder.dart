import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';

class VotingViewHolder extends StatelessWidget {
  final VotingRowViewModel viewModel;
  final bool showTopLine;
  final bool showBottomLine;

  const VotingViewHolder(this.viewModel, this.showTopLine, this.showBottomLine, {Key key})
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
      margin: EdgeInsets.only(left: 4, right: 4),
      child: Center(
        child: Wrap(
          children: <Widget>[
            FittedBox(
              fit: BoxFit.contain,
              child: Text(
                DateFormat("HH:mm").format(viewModel.model.date),
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
    return Expanded(
      child: Card(
        margin: EdgeInsets.only(left: 8, top: 8, bottom: 8,  right: 8),
        elevation: 4,
        child: InkWell(
          onTap: viewModel.itemClick,
          child: Container(
            margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Text(
                    viewModel.model.votingDesc,
                    style: theme.textTheme.overline.copyWith(
                        color: theme.dividerColor,
                        fontSize: 10
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    viewModel.model.title,
                    style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                ),
                TechnicalData(technicalId: viewModel.model.id),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_athens/timeline_flow/screens/list/timeline_row_view_model.dart';

class VotingViewHolder extends StatelessWidget {
  final VotingRowViewModel viewModel;
  final bool showTopLine;
  final bool showBottomLine;

  const VotingViewHolder(this.viewModel, this.showTopLine, this.showBottomLine, {Key key})
      : super(key: key);

  final int hourFlex = 1;
  final int iconFlex = 1;
  final int rowTextFlex = 4;
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
    return Flexible(
      fit: FlexFit.tight,
      flex: hourFlex,
      child: Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        child: Center(
          child: Wrap(
            children: <Widget>[
              FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  DateFormat("HH:mm").format(viewModel.date),
                  style: TextStyle(
                      color: theme.dividerColor, fontSize: 24, fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getIcon(BuildContext context, ThemeData theme) {
    return Flexible(
        fit: FlexFit.tight,
        flex: iconFlex,
        child: Stack(children: <Widget>[
          Center(
            child: Column(children: [
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
          ),
          Center(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: theme.dividerColor, width: lineThickness)),
                  child: LayoutBuilder(
                    builder: (context, constraint) => Icon(
                      MdiIcons.vote,
                      color: theme.dividerColor,
                      size: constraint.biggest.height - 15,
                    ),
                  )),
            ),
          ),
        ]));
  }

  Widget getRowText(BuildContext context, ThemeData theme) {
    return Flexible(
      fit: FlexFit.tight,
      flex: rowTextFlex,
      child: Card(
        margin: EdgeInsets.only(left: 8, top: 8, bottom: 8,  right: 8),
        elevation: 4,
        child: Container(
          margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Text(
                  viewModel.title,
                  style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

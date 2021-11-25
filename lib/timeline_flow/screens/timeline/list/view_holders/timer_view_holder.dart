import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/presentation/delegates/redirection_delegate.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';

class TimerViewHolder extends StatelessWidget with RedirectionDelegate {
  final TimerViewModel viewModel;
  final bool showTopLine;
  final bool showBottomLine;

  const TimerViewHolder(this.viewModel, this.showTopLine, this.showBottomLine,
      {Key? key})
      : super(key: key);

  final double lineThickness = 2;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(children: <Widget>[
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getHourWidget(context, theme),
            getIcon(context, theme),
            getRowText(context, theme),
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
                DateFormat("HH:mm").format(DateTime.now()),
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
            Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                ]
            ),
            Container(
              color: Colors.white,
              child: CircularCountDownTimer(
                duration: 5 * 60,
                fillColor: theme.primaryColor,
                height: 40,
                width: 40,
                ringColor: theme.dividerColor,
                backgroundColor: Colors.white,
                isReverse: true,
                onComplete: viewModel.refresh,
                textStyle: TextStyle(
                  fontSize: 11,
                  color: theme.dividerColor
                ),
                strokeWidth: lineThickness,
              ),
            ),
          ]
      ),
    );
  }

  Widget getRowText(BuildContext context, ThemeData theme) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
        elevation: 4,
        child: Container(
          margin: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Text(
                  "Dzisiaj jest dzień posiedzenia",
                  style: theme.textTheme.overline?.copyWith(
                      color: theme.dividerColor,
                      fontSize: 10
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  "Pobierzemy nowe dane po skończeniu odliczania",
                  style: TextStyle(
                      color: theme.dividerColor, fontSize: 12),
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

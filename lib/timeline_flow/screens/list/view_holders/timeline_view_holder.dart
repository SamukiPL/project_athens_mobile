import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/screens/list/timeline_row_view_model.dart';

class TimelineViewHolder extends StatelessWidget {
  final TimelineRowViewModel viewModel;
  final bool showTopLine;
  final bool showBottomLine;

  const TimelineViewHolder(this.viewModel, this.showTopLine, this.showBottomLine, {Key key})
      : super(key: key);

  final int hourFlex = 1;
  final int iconFlex = 1;
  final int rowTextFlex = 4;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            getHourWidget(context),
            getIcon(context),
            getRowText(context)
          ],
        ),
      ),
//      getLine(context)
    ]);
  }

  Widget getHourWidget(BuildContext context) {
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
                      color: Theme.of(context).dividerColor, fontSize: 24),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getIcon(BuildContext context) {
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
                      thickness: 3, color: Theme.of(context).dividerColor),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Visibility(
                  visible: showBottomLine,
                  child: VerticalDivider(
                      thickness: 3, color: Theme.of(context).dividerColor),
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
                          color: Theme.of(context).dividerColor, width: 3)),
                  child: LayoutBuilder(
                    builder: (context, constraint) => Icon(
                      viewModel.type.getIconForType(),
                      color: Theme.of(context).dividerColor,
                      size: constraint.biggest.height - 15,
                    ),
                  )),
            ),
          ),
        ]));
  }

  Widget getRowText(BuildContext context) {
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
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              getDescription(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget getDescription(BuildContext context) {
    return viewModel.desc != null
        ? Container(
            width: double.infinity,
            child: Text(
              viewModel.desc,
              style: TextStyle(
                  color: Theme.of(context).dividerColor, fontSize: 12),
              textAlign: TextAlign.left,
            ),
          )
        : Container();
  }

  Widget getLine(BuildContext context) {
    return Visibility(
      visible: showBottomLine,
      child: Row(
        children: <Widget>[
          Flexible(fit: FlexFit.tight, flex: hourFlex, child: Container()),
          Flexible(
              fit: FlexFit.tight,
              flex: iconFlex,
              child: Container(
                height: 20,
                child: VerticalDivider(
                    thickness: 3, color: Theme.of(context).dividerColor),
              )),
          Flexible(
            fit: FlexFit.tight,
            flex: rowTextFlex,
            child: Container(),
          )
        ],
      ),
    );
  }
}

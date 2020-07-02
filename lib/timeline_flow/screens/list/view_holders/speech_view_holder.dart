import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/timeline_flow/screens/list/timeline_row_view_model.dart';

class SpeechViewHolder extends StatelessWidget {
  final SpeechRowViewModel viewModel;
  final bool showTopLine;
  final bool showBottomLine;

  const SpeechViewHolder(this.viewModel, this.showTopLine, this.showBottomLine,
      {Key key})
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    height: double.infinity,
                    child: LayoutBuilder(
                      builder: (context, constraint) => FutureBuilder(
                        future: viewModel.thumbnailUrl,
                        builder: (context, AsyncSnapshot<String> snapshot) =>
                            ClipOval(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white
                                ),
                                child: Image.network(
                                  snapshot.data ?? "",
                                  fit: BoxFit.fitWidth,
                                  width: constraint.biggest.height,
                                  errorBuilder: (context, exception, stackTrace) =>  Icon(
                                    Icons.record_voice_over,
                                    color: theme.dividerColor,
                                    size: constraint.biggest.height - 15,
                                  ),
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 8),
                    height: double.infinity,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: theme.dividerColor, width: lineThickness)),
                    )],
              ),
            ),
          ),
        ]));
  }

  Widget getRowText(BuildContext context, ThemeData theme) {
    return Flexible(
      fit: FlexFit.tight,
      flex: rowTextFlex,
      child: Card(
        margin: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
        elevation: 4,
        child: Container(
          margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Text(
                  "WYPOWIEDŹ",
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
                  viewModel.title,
                  style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              getDescription(context, theme)
            ],
          ),
        ),
      ),
    );
  }

  Widget getDescription(BuildContext context, ThemeData theme) {
    return viewModel.desc != null
        ? Container(
            width: double.infinity,
            child: Text(
              viewModel.desc,
              style: TextStyle(
                  color: theme.dividerColor, fontSize: 12),
              textAlign: TextAlign.left,
            ),
          )
        : Container();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/athens_core/presentation/technical_data/technical_data.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_row_view_model.dart';

class SpeechViewHolder extends StatelessWidget {
  final SpeechRowViewModel viewModel;
  final bool showTopLine;
  final bool showBottomLine;

  const SpeechViewHolder(this.viewModel, this.showTopLine, this.showBottomLine,
      {Key key})
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
          AspectRatio(
            aspectRatio: 1.0,
            child: Hero(
              tag: viewModel.model.id,
              child: Container(
                margin: EdgeInsets.all(8),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: theme.dividerColor, width: lineThickness)),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.network(
                      viewModel.model.thumbnailUrl,
                      width: 40,
                      errorBuilder:
                          (context, exception, stackTrace) => Icon(
                            Icons.record_voice_over,
                            color: theme.dividerColor,
                            size: 25,
                          ),
                    ),
                  ),
                ),
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
        margin: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
        elevation: 4,
        child: InkWell(
          onTap: viewModel.itemClick,
          child: Container(
            margin: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
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
                    viewModel.model.personName,
                    style: TextStyle(
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    maxLines: 2,
                    textAlign: TextAlign.left,
                  ),
                ),
                getDescription(context, theme),
                TechnicalData(technicalId: viewModel.model.id)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDescription(BuildContext context, ThemeData theme) {
    return viewModel.model.desc != null
        ? Container(
            width: double.infinity,
            child: Text(
              viewModel.model.desc,
              style: TextStyle(
                  color: theme.dividerColor, fontSize: 12),
              textAlign: TextAlign.left,
            ),
          )
        : Container();
  }
}

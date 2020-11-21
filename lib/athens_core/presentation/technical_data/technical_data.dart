import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_athens/athens_core/configuration/configuration.dart';
import 'package:provider/provider.dart';

class TechnicalData extends StatelessWidget {
  final String technicalId;
  final Map<String, String> additionalIds;

  const TechnicalData({Key key, @required this.technicalId, this.additionalIds})
      : super(key: key);

  _copyToClipboard(String text) {
    Clipboard.setData(new ClipboardData(text: text));
  }

  @override
  Widget build(BuildContext context) {
    final configuration = Provider.of<Configuration>(context);

    return StreamProvider.value(
      value: configuration.showTechnicalData,
      initialData: false,
      child: Consumer<bool>(
        builder: (BuildContext context, bool value, Widget child) =>
            value
                ? Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // generate standard id field, since it's main task
                        // is display current view model context id
                        buildIdField('id', this.technicalId, context),
                        ...buildAdditionalIds(context),
                      ]),
                    )
                : Container(),
      )
    );
  }

  Widget buildIdField(String key, String value, BuildContext context) {
    final theme = Theme.of(context);

    final text = "$key:$value";

    return Container(
      margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
      child: GestureDetector(
          onTap: () => _copyToClipboard(text),
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: TextStyle(color: theme.accentColor, fontSize: 9),
          )
      ),
    );
  }

  List<Widget> buildAdditionalIds(BuildContext context) {
    if (additionalIds != null && additionalIds.length > 0) {
      final List<Widget> widgets = List();

      additionalIds.forEach((key, value) {
        widgets.add(buildIdField(key, value, context));
      });

      return widgets;
    } else {
      return [];
    }
  }
}

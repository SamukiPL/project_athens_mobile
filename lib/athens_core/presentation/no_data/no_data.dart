import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:provider/provider.dart';

class NoData extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color color;

  NoData({this.text, this.textAlign = TextAlign.center, this.color = Colors.black });

  _getDefaultText(BuildContext context) {
    final localization = Provider.of<AppLocalizations>(context);

    return localization.getText().universalNoDataDefaultText();
  }

  Widget build(BuildContext context) {
    final noDataText = this.text != null ? this.text : _getDefaultText(context);

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sentiment_dissatisfied, size: 50, color: this.color,),
          Text(noDataText, textAlign: this.textAlign, style: TextStyle(color: this.color))
        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';

class FullCard extends StatelessWidget {

  final Widget child;
  final double leftPadding;
  final double rightPadding;
  final String header;
  final double headerPadding;
  final String dialogText;

  FullCard({@required this.child, this.leftPadding = 0, this.rightPadding = 0, this.header, this.headerPadding = 0, this.dialogText = ''});

  Widget buildHeader(ThemeData theme, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: headerPadding, right: headerPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              header,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 20
              ),
          ),
          dialogText != '' ?
          GestureDetector(
            onTap: () => openInfoDialog(context),
            child: Icon(
              Icons.help_outline,
              color: Colors.black54,
            )
          )
          : Container()
        ],
      )

    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        padding: EdgeInsets.only(top: 4, bottom: 4),
        child: Container(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: this.leftPadding, right: this.rightPadding),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 2), // changes position of shadow
              )]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              header != null ? this.buildHeader(theme, context) : Container(),
              child
            ],
          ),
        )
    );
  }

  openInfoDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(localizations.getText().universalInformation()),
          content: Text(dialogText),
          actions: [
            FlatButton(
              child: Text(localizations.getText().universalClose()),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
        barrierDismissible: true
    );
  }
}
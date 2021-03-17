import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullCard extends StatelessWidget {

  final Widget child;
  final double leftPadding;
  final double rightPadding;
  final String header;
  final double headerPadding;

  FullCard({@required this.child, this.leftPadding = 0, this.rightPadding = 0, this.header, this.headerPadding = 0});

  Widget buildHeader(ThemeData theme) {
    return Container(
      padding: EdgeInsets.only(left: headerPadding, right: headerPadding),
      child: Text(
          header,
          style: TextStyle(
            color: theme.dividerColor,
            fontWeight: FontWeight.w200,
            fontSize: 20
          ),
      ),

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
              header != null ? this.buildHeader(theme) : Container(),
              child
            ],
          ),
        )
    );
  }
}
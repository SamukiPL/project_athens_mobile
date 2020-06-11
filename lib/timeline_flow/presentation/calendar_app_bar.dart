import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSize CalendarAppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(kToolbarHeight),
    child: _CalendarAppBar(),
  );
}

class _CalendarAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: Center(
              child: Text(
                "15 Kwietnia 2020",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          )
        ],
      )
    );
  }

}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_athens/timeline_flow/presentation/calendar_app_bar_bloc.dart';
import 'package:provider/provider.dart';

PreferredSize CalendarAppBar(CalendarAppBarBloc bloc,
    VoidCallback previousClick, VoidCallback nextClick) {
  return PreferredSize(
    preferredSize: Size.fromHeight(kToolbarHeight),
    child: _CalendarAppBar(
      bloc: bloc,
      previousClick: previousClick,
      nextClick: nextClick,
    ),
  );
}

class _CalendarAppBar extends StatelessWidget {
  final CalendarAppBarBloc bloc;

  final VoidCallback previousClick;
  final VoidCallback nextClick;

  const _CalendarAppBar(
      {Key key,
      @required this.bloc,
      @required this.previousClick,
      @required this.nextClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: kToolbarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: GestureDetector(
                  onTap: previousClick,
                  child: Container(
                    height: double.infinity,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 4,
                child: Center(
                  child: ChangeNotifierProvider<CalendarAppBarBloc>.value(
                    value: bloc,
                    child: Consumer<CalendarAppBarBloc>(
                      builder: (context, bloc, _) => Text(
                        DateFormat("d MMMM y", "pl").format(bloc.date),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: GestureDetector(
                  onTap: nextClick,
                  child: Container(
                    height: double.infinity,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

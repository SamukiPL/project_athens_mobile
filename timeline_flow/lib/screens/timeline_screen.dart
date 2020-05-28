import 'package:athens_core/injections/module.dart';
import 'package:athens_core/presentation/base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:timeline_flow/injections/timeline_module.dart';
import 'package:timeline_flow/presentation/calendar_app_bar.dart';
import 'package:timeline_flow/screens/list/timeline_list.dart';
import 'package:timeline_flow/screens/timeline_bloc.dart';

class TimelineScreen extends BaseScreen<TimelineBloc> {
  @override
  String get appBarTitle => "DUPA";

  @override
  List<Module> getProviders(BuildContext context) {
    return [TimelineModule(context)];
  }

  @override
  Widget buildAppBar(BuildContext context, TimelineBloc bloc) {
    return CalendarAppBar();
  }

  @override
  Widget buildBody(BuildContext context, TimelineBloc bloc) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TimelineList(bloc.adapter)
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, TimelineBloc bloc) {
    return null;
  }

  @override
  bool get showBackArrow => false;

}
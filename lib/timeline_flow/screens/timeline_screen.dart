import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/timeline_flow/injections/timeline_module.dart';
import 'package:project_athens/timeline_flow/presentation/calendar_app_bar.dart';
import 'package:project_athens/timeline_flow/screens/list/timeline_list.dart';
import 'package:project_athens/timeline_flow/screens/timeline_bloc.dart';

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
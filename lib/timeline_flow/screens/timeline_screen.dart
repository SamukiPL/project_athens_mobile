import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/backdrop/backdrop_widget.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/timeline_flow/injections/timeline_module.dart';
import 'package:project_athens/timeline_flow/presentation/calendar_app_bar.dart';
import 'package:project_athens/timeline_flow/presentation/date_picker_fork/date_picker_dialog_custom.dart';
import 'package:project_athens/timeline_flow/presentation/date_picker_fork/date_utils.dart';
import 'package:project_athens/timeline_flow/screens/list/timeline_list.dart';
import 'package:project_athens/timeline_flow/screens/timeline_bloc.dart';

class TimelineScreen extends BaseScreen<TimelineBloc> {
  @override
  String get appBarTitle => "Timeline";

  @override
  List<Module> getProviders(BuildContext context) {
    return [TimelineModule(context)];
  }

  @override
  Widget buildAppBar(BuildContext context, TimelineBloc bloc) {
    return CalendarAppBar(bloc.calendarBloc,
            () => { bloc.setPreviousDate() },
            () => { bloc.setNextDate() });
  }

  @override
  Widget buildBody(BuildContext context, TimelineBloc bloc) {
    return BackdropWidget(
      topChild: TimelineList(bloc.adapter),
    );
  }

  @override
  Widget buildFloatingActionButton(BuildContext context, TimelineBloc bloc) {
    return FloatingActionButton(
      onPressed: () async {
        final picked = await showCustomDatePicker(
            context: context,
            initialDate: bloc.selectedDate,
            firstDate: DateTime.utc(2016),
            lastDate: DateTime.utc(2021),
            selectableDayPredicate: (DateTime date) {
              return bloc.dates.any((element) => dateOnly(element.meetingDate).isAtSameMomentAs(date));
            },
        );
        if (picked != null)
          bloc.loadNewDate(picked);
      },
      child: Icon(Icons.calendar_today),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  @override
  bool get showBackArrow => false;
}
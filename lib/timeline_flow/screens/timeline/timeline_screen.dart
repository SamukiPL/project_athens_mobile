import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_scatter/flutter_scatter.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/backdrop/backdrop_widget.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/injections/timeline_module.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destination_manager.dart';
import 'package:project_athens/timeline_flow/presentation/calendar_app_bar.dart';
import 'package:project_athens/timeline_flow/presentation/date_picker_fork/date_picker_dialog_custom.dart';
import 'package:project_athens/timeline_flow/presentation/date_picker_fork/date_utils.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_list.dart';
import 'package:project_athens/timeline_flow/screens/timeline/outpu.dart';
import 'package:project_athens/timeline_flow/screens/timeline/timeline_bloc.dart';
import 'package:provider/provider.dart';

class TimelineScreen extends BaseScreen<TimelineBloc> {
  @override
  BottomNavItem get currentBottomBarItem => BottomNavItem.TIMELINE;

  @override
  String get appBarTitle => "Timeline";

  @override
  bool get showBackArrow => false;

  @override
  Widget buildAppBar(BuildContext context, TimelineBloc bloc) {
    return CalendarAppBar(bloc.calendarBloc,
            () => { bloc.setPreviousDate() },
            () => { bloc.setNextDate() });
  }

  @override
  Widget buildBody(BuildContext context, TimelineBloc bloc) {
    final screenSize = MediaQuery.of(context).size;
    final ratio = screenSize.width / screenSize.height;

    List<Widget> widgets = List<Widget>();
    Output.output.removeWhere((key, value) => value < 10);
    Output.output.remove("to");
    Output.output.forEach((key, value) {
      widgets.add(
          RotatedBox(
            quarterTurns: value % 2,
            child: Text(
              "#$key",
              style: TextStyle(fontSize: (value/3), color: Colors.white),
            ),
          )
      );
    });
    TimelineDestinationManager timelineNavigation = Provider.of<DestinationManager>(context);

    return StreamProvider<TimelineModel>.value(
      value: bloc.destination,
      updateShouldNotify: (_, current) => goToDestination(context, current, timelineNavigation),
      child: Consumer<TimelineModel>(
        builder: (context, _, child) => child,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: BackdropWidget(
            bottomChild: Container(
              margin: EdgeInsets.all(16),
              child: Scatter(
                fillGaps: true,
                delegate: ArchimedeanSpiralScatterDelegate(
                  ratio: ratio,
                  a: 2.0,
                  b: 2.0,
                ),
                children: widgets,
                overflow: Overflow.visible
              ),
            ),
            topChild: TimelineList(bloc.adapter),
          ),
        ),
      ),
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

  bool goToDestination(BuildContext context, TimelineModel model, TimelineDestinationManager timelineNavigation) {
    switch(model.type) {
      case TimelineModelType.VOTING:
        // TODO: Handle this case.
        break;
      case TimelineModelType.SPEECH:
        timelineNavigation.goToSpeechScreen(context, model);
        break;
    }
    return false;
  }
}
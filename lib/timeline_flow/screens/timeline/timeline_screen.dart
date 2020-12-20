
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/backdrop/backdrop_widget.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/presentation/data_loading/data_loading_widget.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destinations.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destinations.dart';
import 'package:project_athens/timeline_flow/presentation/calendar_app_bar.dart';
import 'package:project_athens/timeline_flow/presentation/date_picker_fork/date_picker_dialog_custom.dart';
import 'package:project_athens/timeline_flow/presentation/date_picker_fork/date_utils.dart';
import 'package:project_athens/timeline_flow/screens/timeline/cloud/noun_cloud.dart';
import 'package:project_athens/timeline_flow/screens/timeline/list/timeline_list.dart';
import 'package:project_athens/timeline_flow/screens/timeline/timeline_bloc.dart';
import 'package:project_athens/voting_flow/navigation/voting_destinations.dart';
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
    final destinationManager = Provider.of<DestinationManager>(context);
    final localizations = Provider.of<AppLocalizations>(context);

    return StreamProvider<TimelineModel>.value(
      value: bloc.destination,
      updateShouldNotify: (_, current) => goToDestination(context, current, destinationManager),
      child: Consumer<TimelineModel>(
        builder: (context, _, child) => child,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: BackdropWidget(
            bottomChild: NounCloud(bloc: bloc.nounCloudBloc),
            topChild: DataLoadingWidget(
              bloc.dataLoadingBloc,
              child: TimelineList(bloc.adapter),
              noDataText: localizations.getText().timelineNoEvents(),
            ),
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

  bool goToDestination(BuildContext context, TimelineModel model, DestinationManager timelineNavigation) {
    switch(model.type) {
      case TimelineModelType.VOTING:
        timelineNavigation.goToDestination(context, VoteDetailsDestination(currentBottomBarItem, model));
        break;
      case TimelineModelType.SPEECH:
        timelineNavigation.goToDestination(context, SpeechDetailsDestination(model));
        break;
      case TimelineModelType.GROUPED_VOTING:
        timelineNavigation.goToDestination(context, GroupDetailsDestination(model));
        break;
    }
    return false;
  }
}
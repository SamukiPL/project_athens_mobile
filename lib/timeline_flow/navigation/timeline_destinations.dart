import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/models/speech_model.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/speeches_flow/injections/speech_module.dart';
import 'package:project_athens/speeches_flow/screens/details/speech_details_screen.dart';
import 'package:project_athens/timeline_flow/injections/group_details_module.dart';
import 'package:project_athens/timeline_flow/injections/timeline_module.dart';
import 'package:project_athens/timeline_flow/screens/group_details/group_details_screen.dart';
import 'package:project_athens/timeline_flow/screens/timeline/timeline_screen.dart';

class TimelineScreenDestination extends Destination<TimelineScreen> {

  TimelineScreenDestination() : super(BottomNavItem.TIMELINE);

  @override
  TimelineScreen getScreen() => TimelineScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [TimelineModule(context)];

}

class SpeechScreenDestination extends Destination<SpeechDetailsScreen> {
  final String _speechId;

  SpeechScreenDestination(this._speechId): super(BottomNavItem.SPEECHES);

  @override
  SpeechDetailsScreen getScreen() => SpeechDetailsScreen();

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [SpeechModule(context, _speechId, false)];

}

class GroupDetailsDestination extends Destination<GroupDetailsScreen> {

  final GroupedVotingModel _groupedModel;

  GroupDetailsDestination(this._groupedModel): super(BottomNavItem.TIMELINE);

  @override
  GroupDetailsScreen getScreen() => GroupDetailsScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [
    GroupDetailsModule(context, _groupedModel)
  ];

}
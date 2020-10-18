import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/timeline_flow/injections/timeline_module.dart';
import 'package:project_athens/speeches_flow/screens/details/speech_details_screen.dart';
import 'package:project_athens/timeline_flow/screens/timeline/timeline_screen.dart';
import 'package:project_athens/speeches_flow/injections/speech_module.dart';

class TimelineScreenDestination extends Destination<TimelineScreen> {

  @override
  TimelineScreen getScreen() => TimelineScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [TimelineModule(context)];

}

class SpeechScreenDestination extends Destination<SpeechDetailsScreen> {
  final SpeechModel speechModel;

  SpeechScreenDestination(this.speechModel);

  @override
  SpeechDetailsScreen getScreen() => SpeechDetailsScreen(
        speechModel: speechModel,
      );

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [SpeechModule(context, speechModel)];

}

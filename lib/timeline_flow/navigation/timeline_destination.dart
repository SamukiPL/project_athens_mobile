import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/injections/timeline_module.dart';
import 'package:project_athens/timeline_flow/screens/speech/speech_screen.dart';
import 'package:project_athens/timeline_flow/screens/timeline/timeline_screen.dart';
import 'package:project_athens/timeline_flow/injections/speech_module.dart';

abstract class TimelineDestination<SCREEN extends BaseScreen> extends Destination<SCREEN> {}

class TimelineScreenDestination extends TimelineDestination<TimelineScreen> {

  @override
  TimelineScreen getScreen() => TimelineScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [TimelineModule(context)];

}

class SpeechScreenDestination extends TimelineDestination<SpeechScreen> {
  final SpeechModel speechModel;

  SpeechScreenDestination(this.speechModel);

  @override
  SpeechScreen getScreen() => SpeechScreen(
        speechModel: speechModel,
      );

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [SpeechModule(context, speechModel)];

}

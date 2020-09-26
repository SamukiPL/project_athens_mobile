import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/injections/timeline_module.dart';
import 'package:project_athens/timeline_flow/screens/speech/speech_screen.dart';
import 'package:project_athens/timeline_flow/screens/timeline_screen.dart';
import 'package:project_athens/timeline_flow/injections/speech_module.dart';

abstract class TimelineDestination<SCREEN extends BaseScreen> {
  SCREEN getScreen();

  List<Module> getScreenModules(BuildContext context);

  void dispose();
}

class TimelineScreenDestination extends TimelineDestination<TimelineScreen> {
  final TimelineModule _timelineModule;

  TimelineScreenDestination._(this._timelineModule);

  factory TimelineScreenDestination(BuildContext context) =>
      TimelineScreenDestination._(TimelineModule(context));

  @override
  TimelineScreen getScreen() => TimelineScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => [_timelineModule];

  @override
  void dispose() {
    _timelineModule.disposeCache();
  }
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

  @override
  void dispose() {}
}

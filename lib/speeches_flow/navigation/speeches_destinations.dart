import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/bottom_navigation_bloc.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/speeches_flow/injections/speech_module.dart';
import 'package:project_athens/speeches_flow/injections/speeches_list_module.dart';
import 'package:project_athens/speeches_flow/screens/details/speech_details_screen.dart';
import 'package:project_athens/speeches_flow/screens/list/speeches_list_screen.dart';

class SpeechesListDestination extends Destination<SpeechesListScreen> {
  SpeechesListDestination() : super(BottomNavItem.SPEECHES);

  @override
  SpeechesListScreen getScreen() => SpeechesListScreen();

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [SpeechesListModule(context)];
}

class SpeechDetailsDestination extends Destination<SpeechDetailsScreen> {
  final String _speechId;
  final bool _isNormalSpeech;

  SpeechDetailsDestination(this._speechId, this._isNormalSpeech, {bool replace = false})
      : super(BottomNavItem.SPEECHES, replace: replace);

  factory SpeechDetailsDestination.nextSpeechReplacement(String speechId, bool normalSpeech) =>
      SpeechDetailsDestination(speechId, normalSpeech, replace: true);

  @override
  SpeechDetailsScreen getScreen() => SpeechDetailsScreen();

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [SpeechModule(context, _speechId, _isNormalSpeech)];
}

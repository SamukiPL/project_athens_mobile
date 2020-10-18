import 'package:flutter/src/widgets/framework.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/athens_core/presentation/base_bloc.dart';
import 'package:project_athens/athens_core/presentation/base_screen.dart';
import 'package:project_athens/speeches_flow/injections/speech_module.dart';
import 'package:project_athens/speeches_flow/injections/speeches_list_module.dart';
import 'package:project_athens/speeches_flow/screens/details/speech_details_screen.dart';
import 'package:project_athens/speeches_flow/screens/list/speeches_list_screen.dart';

class SpeechesListDestination extends Destination<SpeechesListScreen> {
  @override
  SpeechesListScreen getScreen() => SpeechesListScreen();

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [SpeechesListModule(context)];
}

class SpeechDetailsDestination extends Destination<SpeechDetailsScreen> {
  final SpeechModel _speechModel;

  SpeechDetailsDestination(this._speechModel);

  @override
  SpeechDetailsScreen getScreen() => SpeechDetailsScreen(speechModel: _speechModel);

  @override
  List<Module> getScreenModules(BuildContext context) =>
      [SpeechModule(context, _speechModel)];
}

import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/ext/list_extension.dart';
import 'package:project_athens/athens_core/injections/module.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destination.dart';

class TimelineDestinationManager extends DestinationManager {
  List<TimelineDestination> _popStack = List();

  TimelineDestinationManager(BuildContext context) {
    _popStack.add(TimelineScreenDestination(context));
  }

  @override
  Widget currentScreen() => _popStack.last.getScreen();

  @override
  List<Module> getScreenModules(BuildContext context) => _popStack.last.getScreenModules(context);

  @override
  bool goBack() {
    if (_popStack.length == 1) return true;

    _popStack.removeLastIfPossible().dispose();
    notifyListeners();
    return false;
  }

  void goToSpeechScreen(SpeechModel model) {
    final destination = SpeechScreenDestination(model);
    _popStack.add(destination);
    notifyListeners();
  }

}
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destination.dart';
import 'package:project_athens/timeline_flow/screens/speech/speech_screen.dart';
import 'package:project_athens/timeline_flow/screens/timeline_screen.dart';
import 'package:project_athens/athens_core/ext/list_extension.dart';

class TimelineDestinationManager extends DestinationManager {
  List<TimelineDestination> _popStack = List.of([TimelineScreenDestination()]);

  @override
  Widget currentScreen() {
    final lastItem = _popStack.last;
    switch(lastItem.runtimeType) {
      case SpeechScreenDestination:
        SpeechScreenDestination speechScreenDestination = lastItem;
        return SpeechScreen(speechModel: speechScreenDestination.speechModel,);
        break;
    }
    return TimelineScreen();
  }

  @override
  bool goBack() {
    if (_popStack.length == 1) return true;

    _popStack.removeLastIfPossible();
    notifyListeners();
    return false;
  }

  void goToSpeechScreen(SpeechModel model) {
    final destination = SpeechScreenDestination(model);
    _popStack.add(destination);
    notifyListeners();
  }

}
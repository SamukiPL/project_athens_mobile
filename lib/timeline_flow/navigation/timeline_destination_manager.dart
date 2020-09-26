import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destination.dart';

class TimelineDestinationManager extends DestinationManager<TimelineDestination> {

  TimelineDestinationManager(BuildContext context) {
    popStack.add(TimelineScreenDestination(context));
  }

  void goToSpeechScreen(SpeechModel model) {
    final destination = SpeechScreenDestination(model);
    popStack.add(destination);
    notifyListeners();
  }

}
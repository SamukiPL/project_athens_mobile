import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/main/presentation/main_widget.dart';
import 'package:project_athens/timeline_flow/domain/timeline_model.dart';
import 'package:project_athens/timeline_flow/navigation/timeline_destination.dart';

class TimelineDestinationManager extends DestinationManager<TimelineDestination> {

  TimelineDestinationManager() {
    popStack.add(TimelineScreenDestination());
  }

  void goToSpeechScreen(BuildContext context, SpeechModel model) {
    final destination = SpeechScreenDestination(model);
    popStack.add(destination);

    Navigator.push(context, MaterialPageRoute(
      builder: (context) => MainWidget()
    ));
  }

}
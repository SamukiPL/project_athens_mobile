import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_athens/athens_core/models/timeline_model.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/main/presentation/main_widget.dart';
import 'package:project_athens/speeches_flow/navigation/speeches_destination.dart';

class SpeechesDestinationManager extends DestinationManager<SpeechesDestination> {

  SpeechesDestinationManager() {
    popStack.add(SpeechesListDestination());
  }

  void goToSpeechDetails(BuildContext context, SpeechModel model) {
    final destination = SpeechDetailsDestination(model);
    popStack.add(destination);

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => MainWidget()
    ));
  }

}
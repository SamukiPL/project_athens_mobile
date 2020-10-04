import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destination.dart';

class DeputiesDestinationManager extends DestinationManager {

  DeputiesDestinationManager(BuildContext context) {
    popStack.add(DeputiesListDestination(context));
  }

}
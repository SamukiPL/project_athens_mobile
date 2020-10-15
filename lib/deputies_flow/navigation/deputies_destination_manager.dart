import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/deputies_flow/navigation/deputies_destination.dart';
import 'package:project_athens/deputies_utils/domain/deputy_model.dart';
import 'package:project_athens/main/presentation/main_widget.dart';

class DeputiesDestinationManager extends DestinationManager<DeputiesDestination> {

  DeputiesDestinationManager() {
    popStack.add(DeputiesListDestination());
  }

  void goToDeputyDetails(BuildContext context, DeputyModel model) {
    final destination = DeputyDetailsDestination(model);
    popStack.add(destination);

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => MainWidget()
    ));
  }

}
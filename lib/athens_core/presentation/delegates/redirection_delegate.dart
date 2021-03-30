import 'package:flutter/widgets.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:provider/provider.dart';

mixin RedirectionDelegate {

  void goToDestination(BuildContext context, Destination destination) {
    final destinationManager = Provider.of<DestinationManager>(context, listen: false);
    destinationManager.goToDestination(context, destination);
  }

}
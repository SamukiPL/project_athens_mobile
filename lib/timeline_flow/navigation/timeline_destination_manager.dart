import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:flutter/material.dart';
import 'package:project_athens/timeline_flow/screens/timeline_screen.dart';

class TimelineDestinationManager extends DestinationManager {

  @override
  Widget currentScreen() {
    return TimelineScreen();
  }

  @override
  bool goBack() {
    // TODO: implement goBack
    return null;
  }

}
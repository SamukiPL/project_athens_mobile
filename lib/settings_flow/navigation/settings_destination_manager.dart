import 'package:project_athens/athens_core/navigation/destination_manager.dart';
import 'package:project_athens/settings_flow/navigation/settings_destination.dart';

class SettingsDestinationManager extends DestinationManager {

  SettingsDestinationManager() {
    popStack.add(SettingsScreenDestination());
  }

}
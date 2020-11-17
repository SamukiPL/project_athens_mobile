import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:rxdart/rxdart.dart';

class Configuration {
  Configuration() {
    showTechnicalData$ = new BehaviorSubject<bool>.seeded(false);

    _init();
  }

  BehaviorSubject<bool> showTechnicalData$;

  final storage = new FlutterSecureStorage();
  Stream<bool> get showTechnicalData => showTechnicalData$.stream.shareValue();

  _init() async {
    final parseToBool = (String str) => str.toLowerCase() == true.toString().toLowerCase();

    final showTechnicalDataFlag = parseToBool(await storage.read(key: ConfigurationStorageNames.SHOW_TECHNICAL_DATA));
    showTechnicalData$.add(showTechnicalDataFlag);
  }

  updateShowTechnicalData(bool newState) {
    showTechnicalData$.add(newState);

    storage.write(key: ConfigurationStorageNames.SHOW_TECHNICAL_DATA, value: newState.toString());
  }
}
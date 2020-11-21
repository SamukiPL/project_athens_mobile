import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_athens/athens_core/ext/flutter_secure_storage_extension.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:rxdart/rxdart.dart';

class Configuration {
  Configuration() {
    _init();
  }

  BehaviorSubject<bool> _showTechnicalDataSource = new BehaviorSubject<bool>.seeded(false);

  final storage = new FlutterSecureStorage();
  Stream<bool> get showTechnicalData => _showTechnicalDataSource.stream.shareValue();

  _init() async {
    final showTechnicalDataFlag = await storage.readBool(key: ConfigurationStorageNames.SHOW_TECHNICAL_DATA);
    _showTechnicalDataSource.add(showTechnicalDataFlag);
  }

  updateShowTechnicalData(bool newState) {
    _showTechnicalDataSource.add(newState);

    storage.write(key: ConfigurationStorageNames.SHOW_TECHNICAL_DATA, value: newState.toString());
  }

  void dispose() {
    this._showTechnicalDataSource.close();
}
}
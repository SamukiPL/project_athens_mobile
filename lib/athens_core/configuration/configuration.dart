import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_athens/athens_core/ext/flutter_secure_storage_extension.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:rxdart/rxdart.dart';

class Configuration {
  Configuration() {
    _init();
  }

  BehaviorSubject<bool> _showTechnicalDataSource = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<bool> _wakelockOnTimelineSource = BehaviorSubject<bool>.seeded(false);
  ReplaySubject<String> _dashboardTilesConfigSource = ReplaySubject<String>();

  final storage = new FlutterSecureStorage();
  Stream<bool> get showTechnicalData => _showTechnicalDataSource.stream.shareValue();
  Stream<bool> get wakelockOnTimeline => _wakelockOnTimelineSource.stream.shareValue();
  Stream<String> get dashboardTilesConfig => _dashboardTilesConfigSource.shareValue();

  Future<void> _init() async {
    final showTechnicalDataFlag = await storage.readBool(key: ConfigurationStorageNames.SHOW_TECHNICAL_DATA);
    _showTechnicalDataSource.add(showTechnicalDataFlag);

    final wakelockOnTimelineFlag = await storage.readBool(key: ConfigurationStorageNames.WAKELOCK_ON_TIMELINE);
    _wakelockOnTimelineSource.add(wakelockOnTimelineFlag);
    
    final _dashboardTilesConfig = await storage.read(key: ConfigurationStorageNames.DASHBOARD_TILES);
    _dashboardTilesConfigSource.add(_dashboardTilesConfig);
  }

  void updateShowTechnicalData(bool newState) {
    _showTechnicalDataSource.add(newState);

    storage.write(key: ConfigurationStorageNames.SHOW_TECHNICAL_DATA, value: newState.toString());
  }

  void updateWakelockOnTimeline(bool newState) {
    _wakelockOnTimelineSource.add(newState);

    storage.write(key: ConfigurationStorageNames.WAKELOCK_ON_TIMELINE, value: newState.toString());
  }

  void dispose() {
    _showTechnicalDataSource.close();
    _wakelockOnTimelineSource.close();
    _dashboardTilesConfigSource.close();
  }
}

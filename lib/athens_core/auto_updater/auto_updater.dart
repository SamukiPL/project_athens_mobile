
import 'dart:async';
import 'dart:io';

import 'package:in_app_update/in_app_update.dart';
import 'package:rxdart/subjects.dart';

enum CupertinoDialogResponse {
  UPDATE_NOW,
  IGNORE,
  LATER
}

class AutoUpdater {

  final BehaviorSubject<bool> _checkingForUpdateSource = BehaviorSubject.seeded(false);
  Stream<bool> get checkingForUpdateStream => _checkingForUpdateSource.stream;

  Future<void> _updateAndroid() async {
    _checkingForUpdateSource.add(true);
    final updateInfo = await InAppUpdate.checkForUpdate().catchError((err) {

    });
    _checkingForUpdateSource.add(false);

    if (updateInfo != null && updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
      if (updateInfo.updatePriority >= 4) {
        await InAppUpdate.performImmediateUpdate();
      } else {
        await InAppUpdate.startFlexibleUpdate();
        await InAppUpdate.completeFlexibleUpdate();
        return Future.value(true);
      }
    }

    return Future.value(false);
  }

  /// Returns whether updater successfully fetched new update
  Future<void> checkForUpdates() async {
    if (Platform.isAndroid) {
      return _updateAndroid();
    } else if (Platform.isIOS) {
      // currently not supported, due to impl errors of upgrader
      // return _updateiOS();
    }
  }

  dispose() {
    _checkingForUpdateSource.close();
  }
}
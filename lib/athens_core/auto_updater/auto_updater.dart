
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:rxdart/rxdart.dart';
import 'package:upgrader/upgrader.dart';

enum CupertinoDialogResponse {
  UPDATE_NOW,
  IGNORE,
  LATER
}

class AutoUpdater {

  AutoUpdater();

  final Upgrader _upgrader = Upgrader();
  late BuildContext _context;

  final BehaviorSubject<bool> _checkingForUpdateSource = BehaviorSubject.seeded(false);
  Stream<bool> get checkingForUpdateStream => _checkingForUpdateSource.stream;

  late Timer _timer;

  void _initiOSUpgrader() {
    _upgrader.countryCode = "pl";
  }

  void _initUpdateInterval() {
    _timer = Timer.periodic(new Duration(minutes: 15), (timer) => checkForUpdates());
  }

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

  // Future<void> _updateiOS() async {
  //   // final isAvailable = await _upgrader.isUpdateAvailable();
  //   final isAvailable = true;
  //
  //   if (isAvailable) {
  //     final userResponse = await showDialog(
  //         context: _context,
  //         builder: (context) => AlertDialog(
  //           title: Text(
  //             // _localizations.getText().universalUpdateCupertinoDialogTitle()
  //             "Zaktualizować aplikacje?"
  //           ),
  //           content: Text(
  //             // _localizations.getText().universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow()
  //             "Chcesz zaktualizować aplikacje teraz?"
  //           ),
  //           actions: [
  //             MaterialButton(
  //               // isDefaultAction: true,
  //               child: Text(
  //                 // _localizations.getText().universalUpdateCupertinoDialogButtonUpdateNow()
  //                 "Aktualizuj"
  //               ),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             MaterialButton(
  //               child: Text(
  //                 // _localizations.getText().universalUpdateCupertinoDialogButtonIgnore()
  //                 "Ignoruj"
  //               ),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //             MaterialButton(
  //               child: Text(
  //                 // _localizations.getText().universalUpdateCupertinoDialogButtonLater()
  //                 "Później"
  //               ),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //             ),
  //           ],
  //         )
  //     );
  //   }
  //
  //   return false;
  // }

  void init(BuildContext _context) {
    this._context = _context;

    _initiOSUpgrader();
    _initUpdateInterval();
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
    _timer.cancel();
  }
}

import 'dart:async';
import 'dart:io';

import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:rxdart/subjects.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

enum CupertinoDialogResponse {
  UPDATE_NOW,
  IGNORE,
  LATER
}

class AutoUpdater {
  AutoUpdater(this._remoteConfiguration, this._localizations) {
    _initMinimalVersionCheck();
  }

  final Upgrader _upgrader = Upgrader();
  final RemoteConfiguration _remoteConfiguration;
  final AppLocalizations _localizations;
  late final StreamSubscription<void> _configChangeSub;
  late final Timer _timer;

  final BehaviorSubject<bool> _checkingForUpdateSource = BehaviorSubject.seeded(false);
  Stream<bool> get checkingForUpdateStream => _checkingForUpdateSource.stream;


  void _initMinimalVersionCheck() {
    _configChangeSub = _remoteConfiguration.dataFetched.listen((event) async {
      final appInfo = await PackageInfo.fromPlatform();
      Version currentVersion = Version.parse(appInfo.version);

      // final bool updateToPerform = _checkPlatformVersions(_remoteConfiguration.minimalVersions!, currentVersion, true);
      // if (!updateToPerform) _checkPlatformVersions(_remoteConfiguration.recommendedVersions!, currentVersion, false);
    });
    _timer = Timer.periodic(new Duration(minutes: 15), (timer) => checkForUpdates());
  }



  void _openCupertinoUpdateDialog(bool critical) {
    // final String title = critical
    //     ? _localizations.getText().universalUpdateCupertinoDialogImmediateUpdateTitle()
    //     : _localizations.getText().universalUpdateCupertinoDialogTitle();
    //
    // final String content = critical
    //     ? _localizations.getText().universalUpdateCupertinoDialogImmediateUpdateContent()
    //     : _localizations.getText().universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow();
    //
    // final List<CupertinoDialogAction> actions = [
    //   CupertinoDialogAction(
    //     child: Text(
    //       _localizations.getText().universalUpdateCupertinoDialogButtonUpdateNow()
    //     ),
    //     onPressed: () => _launchAppStore(),
    //   )
    // ];
    //
    // if (!critical) {
    //   actions.insert(
    //     0,
    //     CupertinoDialogAction(
    //       child: Text(
    //           _localizations.getText().universalUpdateCupertinoDialogButtonLater()
    //       ),
    //     )
    //   );
    // }

    // showCupertinoDialog(
    //     context: _context,
    //     builder: (_) => CupertinoAlertDialog(
    //       title: Text(title),
    //       content: Text(content),
    //       actions: actions
    //     ),
    //     barrierDismissible: !critical
    // );
  }

  void _launchAppStore() {
    launch("https://itunes.apple.com/pl/app/apple-store/1578168101");
  }

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
    _configChangeSub.cancel();
    _timer.cancel();
  }
}
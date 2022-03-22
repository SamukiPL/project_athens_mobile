import 'dart:async';
import 'dart:io';

import 'package:in_app_update/in_app_update.dart';
import 'package:package_info/package_info.dart';
import 'package:project_athens/athens_core/configuration/configuration_delegate.dart';
import 'package:project_athens/athens_core/configuration/configuration_storage_names.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration.dart';
import 'package:project_athens/athens_core/i18n/localization.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_change_notifier.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

class RemoteConfigurationManagerBloc extends BaseChangeNotifier
    with ConfigurationDelegate<DateTime?, DateTime> {
  final RemoteConfiguration _remoteConfiguration;
  late final StreamSubscription<void> _configChangeSub;

  bool showUpdateDialog = false;
  bool isCriticalUpdate = false;
  bool showUpdatedPrivacyPolicy = false;

  @override
  get defaultStorageValue => null;

  @override
  String get preferenceName =>
      ConfigurationStorageNames.LAST_PRIVACY_POLICY_VERSION;

  RemoteConfigurationManagerBloc(this._remoteConfiguration) {
    _configChangeSub = _remoteConfiguration.dataFetched
        .handleError((err) {})
        .listen((event) => _configRefreshed());
  }

  void forceRefreshConfig() {
    _remoteConfiguration.refresh();
  }

  Future<void> checkForInitialAgreement() async {
    final DateTime? agreementVersion = await fetchPreference(null);

    if (agreementVersion == null) {
      showUpdatedPrivacyPolicy = true;
      notifyListeners();
    }
  }

  void resetAgreementFlag() {
    showUpdatedPrivacyPolicy = false;
    notifyListeners();
  }

  void handleAndroid() async {
    if (isCriticalUpdate) {
      return await InAppUpdate.performImmediateUpdate();
    } else {
      await InAppUpdate.startFlexibleUpdate();
      await InAppUpdate.completeFlexibleUpdate();
    }
  }

  void launchAppStore() {
    launch("https://itunes.apple.com/pl/app/apple-store/1578168101");
  }

  String getCupertinoUpdateTitle(AppLocalizations localizations) {
    return isCriticalUpdate
        ? localizations
            .getText()
            .universalUpdateCupertinoDialogImmediateUpdateTitle()
        : localizations.getText().universalUpdateCupertinoDialogTitle();
  }

  String getCupertinoUpdateContent(AppLocalizations localizations) {
    return isCriticalUpdate
        ? localizations
            .getText()
            .universalUpdateCupertinoDialogImmediateUpdateContent()
        : localizations
            .getText()
            .universalUpdateCupertinoDialogWouldYouLikeToUpdateAppNow();
  }

  void _configRefreshed() {
    _checkForUpdates();
    _checkForPrivacyPolicyUpdate();

    if (showUpdateDialog || showUpdatedPrivacyPolicy) {
      notifyListeners();
    }
  }

  void _checkForUpdates() {
    if (Platform.isIOS) {
      _isUpdateAvailable(
        _remoteConfiguration.minimalVersions!.iOS,
        _remoteConfiguration.recommendedVersions!.iOS,
      );
    }

    if (Platform.isAndroid) {
      _isUpdateAvailable(
        _remoteConfiguration.minimalVersions!.android,
        _remoteConfiguration.recommendedVersions!.android,
      );
    }
  }

  void _checkForPrivacyPolicyUpdate() async {
    final DateTime? agreementVersion = await fetchPreference(null);

    if (agreementVersion == null) {
      showUpdatedPrivacyPolicy = true;
      return;
    }

    final DateTime currentAgreementVersion =
        _remoteConfiguration.privacyPolicyVersion;

    if (currentAgreementVersion.millisecondsSinceEpoch >
        agreementVersion.millisecondsSinceEpoch) {
      showUpdatedPrivacyPolicy = true;
    }
  }

  _getUpdateSeverity(Version targetVersion, Version currentVersion) {
    if (targetVersion.major > currentVersion.major) {
      return UPDATE_SEVERITY.MAJOR;
    }

    if (targetVersion.minor > currentVersion.minor) {
      return UPDATE_SEVERITY.MINOR;
    }

    if (targetVersion.patch > currentVersion.patch) {
      return UPDATE_SEVERITY.PATCH;
    }
  }

  UPDATE_SEVERITY? _checkPlatformVersions(
      Version targetVersion, Version currentVersion, bool enforceMajor) {
    if (targetVersion > currentVersion) {
      return enforceMajor
          ? UPDATE_SEVERITY.MAJOR
          : _getUpdateSeverity(targetVersion, currentVersion);
    }

    return null;
  }

  void _isUpdateAvailable(
      Version minimalVersion, Version recommendedVersion) async {
    final appInfo = await PackageInfo.fromPlatform();
    Version currentVersion = Version.parse(appInfo.version);

    final UPDATE_SEVERITY? requiredUpdate =
        _checkPlatformVersions(minimalVersion, currentVersion, true);
    final UPDATE_SEVERITY? recommendedUpdate =
        _checkPlatformVersions(recommendedVersion, currentVersion, false);

    isCriticalUpdate = requiredUpdate == UPDATE_SEVERITY.MAJOR;
    showUpdateDialog = requiredUpdate != null || recommendedUpdate != null;
  }

  @override
  void dispose() {
    _configChangeSub.cancel();
    super.dispose();
  }
}

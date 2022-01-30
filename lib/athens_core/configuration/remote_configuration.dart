import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/athens_core/configuration/domain/get_remote_configuration_use_case.dart';
import 'package:project_athens/athens_core/configuration/domain/platform_app_versions_model.dart';
import 'package:project_athens/athens_core/configuration/network/get_remote_configuration_response.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:version/version.dart';

import 'domain/platform_app_versions_model.dart';

class RemoteConfiguration {
  final GetRemoteConfigurationUseCase _getRemoteConfigurationUseCase;
  final BuildContext context;

  RemoteConfiguration(this._getRemoteConfigurationUseCase, this.context);

  int? _cadence;
  DateTime? _privacyPolicyVersion;
  PlatformAppVersionsModel? _minimalVersions;
  PlatformAppVersionsModel? _recommendedVersions;
  bool _isInitialized = false;

  int get cadence => _cadence!;
  DateTime get privacyPolicyVersion => _privacyPolicyVersion!;

  PlatformAppVersionsModel? get minimalVersions => _minimalVersions!;
  PlatformAppVersionsModel? get recommendedVersions => _recommendedVersions!;

  get isInitialized => _isInitialized;

  final ReplaySubject<void> _dataFetchedSource = ReplaySubject<void>(maxSize: 1);
  Stream<void> get dataFetched => _dataFetchedSource.stream;

  late StreamSubscription? _refreshSub;

  final ReplaySubject<void> _forceRefreshSource = ReplaySubject<void>(maxSize: 1);
  Stream<void> get _forceRefreshStream => _forceRefreshSource.stream;

  init() {
    _refreshSub = Rx.combineLatest2(
        Rx.timer(null, Duration(hours: 1)).startWith(null),
        _forceRefreshStream.startWith(null),
        (a, b) => null)
        .listen((event) => _fetchRemoteConfig());
  }

  refresh() {
    _forceRefreshSource.add(null);
  }

  _fetchRemoteConfig() async {
    final response = await _getRemoteConfigurationUseCase(BaseParams());

    if (response is Failure) { 
      return null;
    }

    final GetRemoteConfigurationConfig config = (response as Success<GetRemoteConfigurationResponse>).value.config;

    _isInitialized = true;
    _cadence = config.cadence;
    _privacyPolicyVersion = config.privacyPolicyVersion;

    _minimalVersions = PlatformAppVersionsModel(
        Version.parse(config.minimalAppVersion.iOS),
        Version.parse(config.minimalAppVersion.iPadOS),
        Version.parse(config.minimalAppVersion.android)
    );

    _recommendedVersions = PlatformAppVersionsModel(
        Version.parse(config.recommendedAppVersion.iOS),
        Version.parse(config.recommendedAppVersion.iPadOS),
        Version.parse(config.recommendedAppVersion.android)
    );

    _dataFetchedSource.add(null);
  }

  void dispose() {
    _refreshSub?.cancel();
    _dataFetchedSource.close();
    _forceRefreshSource.close();
  }
}

enum UPDATE_SEVERITY {
  MAJOR,
  MINOR,
  PATCH
}
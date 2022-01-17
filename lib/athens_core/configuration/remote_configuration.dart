import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/configuration/domain/get_remote_configuration_use_case.dart';
import 'package:project_athens/athens_core/configuration/network/get_remote_configuration_response.dart';
import 'package:project_athens/athens_core/domain/base_list/base_params.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:rxdart/rxdart.dart';
import 'package:version/version.dart';

class RemoteConfiguration {
  final GetRemoteConfigurationUseCase _getRemoteConfigurationUseCase;
  final BuildContext context;

  RemoteConfiguration(this._getRemoteConfigurationUseCase, this.context);

  int? _cadence;
  Version? _androidVersion;
  Version? _iOSVersion;
  Version? _iPadOSVersion;

  bool _isInitialized = false;

  int get cadence => _cadence!;
  Version get androidVersion => _androidVersion!;
  Version get iOSVersion => _iOSVersion!;
  Version get iPadOSVersion => _iPadOSVersion!;

  get isInitialized => _isInitialized;

  final ReplaySubject<void> _dataFetchedSource = ReplaySubject<void>(maxSize: 1);
  Stream<void> get dataFetched => _dataFetchedSource.stream;

  late StreamSubscription? refreshSub;

  init() {
    refreshSub = Rx.timer(null, Duration(hours: 1))
        .startWith(null)
        .listen((event) => _fetchRemoteConfig());
  }

  _fetchRemoteConfig() async {
    final response = await _getRemoteConfigurationUseCase(BaseParams()).catchError((err) => print(err.toString()));

    if (response is Failure) { 
      return;
    }

    final GetRemoteConfigurationConfig config = (response as Success<GetRemoteConfigurationResponse>).value.config;

    _isInitialized = true;
    _cadence = config.cadence;
    _androidVersion = Version.parse(config.minimalAppVersion.android);
    _iOSVersion = Version.parse(config.minimalAppVersion.iOS);
    _iPadOSVersion = Version.parse(config.minimalAppVersion.iPadOS);

    print('get config');
    
    _dataFetchedSource.add(null);
  }

  void dispose() {
    refreshSub?.cancel();
    _dataFetchedSource.close();
  }
}

enum UPDATE_SEVERITY {
  MAJOR,
  MINOR,
  PATCH
}
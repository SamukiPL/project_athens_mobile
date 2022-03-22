import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/athens_core/auth/auth_repository.dart';
import 'package:project_athens/athens_core/auth/auth_storage.dart';
import 'package:project_athens/athens_core/auth/storage/tokens.dart';
import 'package:project_athens/athens_core/chopper/jwt_decode.dart';
import 'package:project_athens/athens_core/configuration/remote_configuration.dart';
import 'package:project_athens/athens_core/ext/string_extension.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rxdart/rxdart.dart';

class SplashScreenBloc extends BaseBloc {
  final Jwt _jwt = Jwt();

  final AuthStorage _authStorage = AuthStorage();

  final AuthRepository _authRepository;

  final SubscribedDeputiesCache _subscribedDeputiesCache;

  final RemoteConfiguration _remoteConfiguration;

  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectionChangedSub;

  SplashScreenBloc(this._authRepository, this._subscribedDeputiesCache,
      this._remoteConfiguration) {
    _connectionChangedSub = _connectivity.onConnectivityChanged.listen((event) {
      _hasAnyConnectionSource.add(event != ConnectivityResult.none);
    });
  }

  final StreamController<SplashDirection> _direction =
      BehaviorSubject<SplashDirection>();

  Stream<SplashDirection> get direction => _direction.stream;

  ReplaySubject<bool> _hasAnyConnectionSource = ReplaySubject<bool>(maxSize: 1);
  Stream<bool> get hasAnyConnection => _hasAnyConnectionSource.stream;

  Future<void> checkDirection() async {
    final bool isConnected = await checkConnection();

    if (!isConnected) {
      _connectionChangedSub =
          _connectivity.onConnectivityChanged.listen((event) async {
        if (event != ConnectivityResult.none) {
          await _remoteConfiguration.refresh();
          _connectionChangedSub?.cancel();
          _connectionChangedSub = null;
          checkDirection();
        }
      });
      return;
    }

    var tokens = await _authStorage.provideTokens();

    if (tokens.accessToken.isNullOrEmpty) {
      _direction.add(SplashDirection.LOGIN);
      return;
    } else if (isMockedToken(tokens.accessToken!)) {
      _direction.add(SplashDirection.MAIN_GUEST);
      return;
    }

    var tokenExp = _jwt.getJwtExp(tokens.accessToken!) - 120;
    var now = DateTime.now().millisecondsSinceEpoch / 1000;

    try {
      if (tokenExp <= now) {
        await _authRepository.refreshTokens(tokens.refreshToken ?? "");
      }
      await _subscribedDeputiesCache.subscribedDeputies;
      _direction.add(SplashDirection.MAIN);
    } on DioError catch (err) {
      if (err.response?.statusCode == 401) {
        _authStorage.removeTokens();
      }

      _direction.add(SplashDirection.LOGIN);
    } on Exception {
      _direction.add(SplashDirection.LOGIN);
    }
  }

  bool isMockedToken(String accessToken) {
    Map<String, dynamic> decodedToken = Jwt().parseJwt(accessToken);
    if (decodedToken.containsKey('isMock') &&
        decodedToken['isMock'] != null &&
        decodedToken['isMock'] == true) {
      return true;
    }
    return false;
  }

  Future<bool> checkConnection() async {
    final ConnectivityResult result = await _connectivity.checkConnectivity();

    _hasAnyConnectionSource.add(result != ConnectivityResult.none);

    return result != ConnectivityResult.none;
  }

  @override
  void dispose() {
    _direction.close();

    _connectionChangedSub?.cancel();
    _hasAnyConnectionSource.close();
  }
}

enum SplashDirection { MAIN, MAIN_GUEST, LOGIN }

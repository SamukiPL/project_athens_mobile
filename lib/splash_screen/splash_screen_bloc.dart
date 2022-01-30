import 'dart:async';

import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/auth/auth_repository.dart';
import 'package:project_athens/athens_core/auth/auth_storage.dart';
import 'package:project_athens/athens_core/chopper/jwt_decode.dart';
import 'package:project_athens/athens_core/domain/result.dart';
import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/deputies_utils/cache/subscribed_deputies_cache.dart';
import 'package:rxdart/rxdart.dart';

class SplashScreenBloc extends BaseBloc {
  final Jwt _jwt = Jwt();

  final AuthStorage _authStorage = AuthStorage();

  final AuthRepository _authRepository;

  final SubscribedDeputiesCache _subscribedDeputiesCache;

  SplashScreenBloc(this._authRepository, this._subscribedDeputiesCache);

  final StreamController<SplashDirection> _direction =
      BehaviorSubject<SplashDirection>();

  Stream<SplashDirection> get direction => _direction.stream;

  Future<void> checkDirection() async {
    var tokens = await _authStorage.provideTokens();

    if (tokens.accessToken == null) {
      _direction.add(SplashDirection.LOGIN);
      return;
    }

    var tokenExp = _jwt.getJwtExp(tokens.accessToken) - 120;
    var now = DateTime.now().millisecondsSinceEpoch / 1000;

    try {
      if (tokenExp <= now) {
        await _authRepository.refreshTokens(tokens.refreshToken);
      }
      await _subscribedDeputiesCache.subscribedDeputies;
      _direction.add(SplashDirection.MAIN);
    } on DioError {
      _authStorage.removeTokens();
      _direction.add(SplashDirection.LOGIN);
    }
  }

  @override
  void dispose() {
    _direction.close();
  }
}

enum SplashDirection { MAIN, LOGIN }

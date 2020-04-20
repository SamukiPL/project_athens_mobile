import 'dart:async';
import 'dart:io';

import 'package:athens_core/auth/auth_repository.dart';
import 'package:athens_core/auth/auth_storage.dart';
import 'package:athens_core/chopper/client_errors.dart';
import 'package:athens_core/chopper/jwt_decode.dart';
import 'package:athens_core/presentation/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SplashScreenBloc extends BaseBloc {
  final Jwt _jwt = Jwt();

  final AuthStorage _authStorage = AuthStorage();

  final AuthRepository _authRepository;

  SplashScreenBloc(this._authRepository);

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

    if (tokenExp > now) {
      _direction.add(SplashDirection.MAIN);
      return;
    }

    try {
      await _authRepository.refreshTokens(tokens.refreshToken);
      _direction.add(SplashDirection.MAIN);
    } on SocketException {
      _direction.add(SplashDirection.MAIN);
    } on UnauthorizedError {
      _direction.add(SplashDirection.LOGIN);
    }
  }

  @override
  void dispose() {
    _direction.close();
  }
}

enum SplashDirection { MAIN, LOGIN }

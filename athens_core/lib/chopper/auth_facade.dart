import 'package:athens_core/auth/auth_repository.dart';
import 'package:athens_core/auth/auth_storage.dart';

import 'jwt_decode.dart';

class AuthFacade {

  final Jwt _jwt = Jwt();

  final AuthStorage _storage = AuthStorage();

  final AuthRepository _repository;

  AuthFacade(this._repository) {
    initialization = _provideTokens();
  }

  Future initialization;

  String _accessToken;
  String _refreshToken;
  int _tokenExp;

  Future<String> get accessToken => _manageAccessToken();

  Future<void> _provideTokens() async {
    var tokens = await _storage.provideTokens();

    _accessToken = tokens.accessToken;
    _refreshToken = tokens.refreshToken;
    _tokenExp = _jwt.getJwtExp(_accessToken) - 120;
  }

  Future<String> _manageAccessToken() async {
    await initialization;
    var now = DateTime.now().millisecondsSinceEpoch / 1000;
    if (now < _tokenExp) return _accessToken;

    var newTokens = await _repository.refreshTokens(_refreshToken);
    _accessToken = newTokens.accessToken;
    _tokenExp = _jwt.getJwtExp(newTokens.accessToken);

    return _accessToken;
  }

}
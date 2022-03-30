import 'package:dio/dio.dart';
import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:project_athens/athens_core/auth/auth_repository.dart';
import 'package:project_athens/athens_core/auth/auth_storage.dart';
import 'package:project_athens/athens_core/ext/string_extension.dart';

import 'jwt_decode.dart';

class AuthFacade {
  final Jwt _jwt = Jwt();

  final AuthStorage _storage = AuthStorage();

  final AuthRepository _repository;

  AuthFacade(this._repository) {
    initialization = _provideTokens();
  }

  Future? initialization;

  String? _accessToken;
  String? _refreshToken;
  int? _tokenExp;

  Future<String> get accessToken => _manageAccessToken();

  Future<bool> _provideTokens() async {
    var tokens = await _storage.provideTokens();
    if (tokens.accessToken.isNullOrEmpty) return false;

    _accessToken = tokens.accessToken;
    _refreshToken = tokens.refreshToken;
    _tokenExp = _jwt.getJwtExp(_accessToken!) - 120;
    return true;
  }

  Future<String> _manageAccessToken() async {
    await initialization;
    if (_accessToken == null && !await _provideTokens()) return "";

    final now = DateTime.now().millisecondsSinceEpoch / 1000;
    if (now < _tokenExp!) return _accessToken!;

    final newTokens = await _repository.refreshTokens(_refreshToken!).catchError((err) async {
      print('An error occured while trying to refresh tokens');
      Fimber.e(err.toString());

      if (err is DioError && err.response?.statusCode == 401) {
        await _storage.removeTokens();
        clearTokens();
      }

      throw err;
    });

    _accessToken = newTokens.accessToken;
    _tokenExp = _jwt.getJwtExp(newTokens.accessToken!);

    return _accessToken!;
  }

  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
  }
}

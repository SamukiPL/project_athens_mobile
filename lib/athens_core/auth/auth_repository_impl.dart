import 'package:project_athens/athens_core/auth/auth_repository.dart';

import 'package:project_athens/athens_core/auth/auth_repository.dart';
import 'package:project_athens/athens_core/auth/network/auth_api.dart';
import 'package:project_athens/athens_core/auth/network/auth_request.dart';
import 'package:project_athens/athens_core/auth/network/auth_response.dart';
import 'package:project_athens/athens_core/auth/storage/tokens.dart';

import 'auth_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi authApi;

  final AuthStorage storage = AuthStorage();

  AuthRepositoryImpl(this.authApi);

  @override
  Future<Tokens> refreshTokens(String refreshToken) async {
    var response = await authApi.refreshTokens(AuthRequest(refreshToken));

    var authResponse = AuthResponse.fromJson(response.body);

    var newAccessToken = authResponse.accessToken;
    var newRefreshToken = authResponse.refreshToken == null
        ? refreshToken
        : authResponse.refreshToken;

    await storage.saveTokens(newAccessToken, newRefreshToken);

    return Tokens(newAccessToken, newRefreshToken);
  }
}


import 'package:project_athens/athens_core/auth/storage/tokens.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project_athens/athens_core/chopper/jwt_decode.dart';

class AuthStorage {

  static String accessTokenKey = "access_token";
  static String refreshTokenKey = "refresh_token";

  Future<Tokens> provideTokens() async {
    final storage = FlutterSecureStorage();

    var accessToken = await storage.read(key: accessTokenKey);
    var refreshToken = await storage.read(key: refreshTokenKey);

    return Tokens(accessToken, refreshToken);
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final storage = FlutterSecureStorage();

    await storage.write(key: accessTokenKey, value: accessToken);
    await storage.write(key: refreshTokenKey, value: refreshToken);
  }

  Future<void> saveAccessToken(String accessToken) async {
    final storage = FlutterSecureStorage();

    await storage.write(key: accessTokenKey, value: accessToken);
  }

  Future<void> removeTokens() async {
    final storage = FlutterSecureStorage();

    await storage.delete(key: accessTokenKey);
    await storage.delete(key: refreshTokenKey);
  }

  Future<String> getUserName() async {
    final Tokens tokens = await provideTokens();

    Map<String, dynamic> decodedToken = Jwt().parseJwt(tokens.accessToken);

    String userName = '';

    if (decodedToken.containsKey('firstName') && decodedToken['firstName'] != null && decodedToken['firstName'] != "") {
      userName = decodedToken['firstName'];

      if (decodedToken.containsKey('lastName') && decodedToken['lastName'] != null && decodedToken['lastName'] != "") {
        userName = userName + ' ' + decodedToken['lastName'];
      }
    } else {
      userName = decodedToken['login'];
    }

    return userName;
  }
}
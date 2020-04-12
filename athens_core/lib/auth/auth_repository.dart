import 'storage/tokens.dart';

abstract class AuthRepository {
  Future<Tokens> refreshTokens(String refreshToken);
}
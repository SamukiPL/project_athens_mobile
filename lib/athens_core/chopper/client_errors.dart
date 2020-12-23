import 'dart:io';

class AuthException implements IOException {
  final int code = 401;
}

import 'dart:io';

abstract class ClientError implements IOException {}

class BadRequestError implements ClientError {
  final int code = 400;
}

class UnauthorizedError implements ClientError {
  final int code = 401;
}

class ForbiddenError implements ClientError {
  final int code = 403;
}

class NotFoundError implements ClientError {
  final int code = 404;
}

class MethodNotAllowedError implements ClientError {
  final int code = 405;
}
import 'dart:io';

abstract class ClientError implements IOException {}

class BadRequestError implements ClientError {}

class UnauthorizedError implements ClientError {}

class ForbiddenError implements ClientError {}

class NotFoundError implements ClientError {}

class MethodNotAllowedError implements ClientError {}
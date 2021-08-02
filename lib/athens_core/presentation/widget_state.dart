
import 'package:dio/dio.dart';
import 'package:project_athens/athens_core/chopper/client_errors.dart';
import 'package:project_athens/athens_core/navigation/destination_manager.dart';

class WidgetState {
  WidgetState._();

  factory WidgetState.success() = SuccessState;
  factory WidgetState.error(ErrorType type) = ErrorState;
  factory WidgetState.authFailure() = AuthFailure;
  factory WidgetState.redirection(Destination destination) = Redirection;
}

class SuccessState extends WidgetState {
  SuccessState(): super._();
}

class AuthFailure extends WidgetState {
  AuthFailure(): super._();
}

class Redirection extends WidgetState {
  final Destination destination;
  Redirection(this.destination): super._();
}

enum ErrorType {
  NETWORK, SERVER, AUTH, UNKNOWN
}

class ErrorState extends WidgetState {
  final ErrorType type;
  ErrorState(this.type): super._();
}

extension StateExceptionExtension on Exception {

  ErrorType parseServerError() {
    DioError err = this as DioError;

    switch (err.response.statusCode) {
      case 401: return ErrorType.AUTH;
      default: return ErrorType.SERVER;
    }
  }

  ErrorType getErrorType() {
    if (this is DioError) {
      DioError dioError = this;
      switch(dioError.type) {
        case DioErrorType.receiveTimeout:
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.other:
          return ErrorType.NETWORK;
          break;
        case DioErrorType.response:
          return parseServerError();
        case DioErrorType.cancel:
        return ErrorType.SERVER;
          break;
      }
    } else if (this is AuthException) {
      return ErrorType.AUTH;
    }
    return ErrorType.UNKNOWN;
  }

  WidgetState getWidgetState() {
      ErrorType type = getErrorType();

      if (type == ErrorType.AUTH)
        return WidgetState.authFailure();

      return WidgetState.error(type);
  }

}
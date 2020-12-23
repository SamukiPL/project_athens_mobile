import 'dart:io';

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
  NETWORK, SERVER, UNKNOWN
}

class ErrorState extends WidgetState {
  final ErrorType type;
  ErrorState(this.type): super._();
}

extension StateExceptionExtension on Exception {

  WidgetState getWidgetState() {
      ErrorType type;
      if (this is DioError) {
        DioError dioError = this;
        switch(dioError.type) {
          case DioErrorType.RECEIVE_TIMEOUT:
          case DioErrorType.CONNECT_TIMEOUT:
          case DioErrorType.SEND_TIMEOUT:
          case DioErrorType.DEFAULT:
            type = ErrorType.NETWORK;
            break;
          case DioErrorType.RESPONSE:
          case DioErrorType.CANCEL:
            type = ErrorType.SERVER;
            break;
        }
      } else if (this is AuthException) {
        return WidgetState.authFailure();
      } else {
        type = ErrorType.UNKNOWN;
      }
      return WidgetState.error(type);
  }

}
class LoggedState {
  const LoggedState._();

  bool get isLogged => this is UserLogged;
  bool get isGuest => this is GuestLogged;

  const factory LoggedState.userLogged() = UserLogged;
  const factory LoggedState.guestLogged() = GuestLogged;
}

class UserLogged extends LoggedState {
  const UserLogged() : super._();
}

class GuestLogged extends LoggedState {
  const GuestLogged() : super._();
}
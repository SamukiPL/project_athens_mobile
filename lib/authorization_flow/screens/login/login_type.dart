class LoginType {
  const LoginType._();

  factory LoginType.normal() = NormalLogin;
  factory LoginType.guest() = GuestLogin;
}

class NormalLogin extends LoginType {
  const NormalLogin() : super._();
}

class GuestLogin extends LoginType {
  const GuestLogin() : super._();
}
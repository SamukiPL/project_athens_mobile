class LoginParams {

  final String? login;
  final String password;
  final String? email;

  LoginParams({this.login, required this.password, this.email}) : assert(
    login != null || email != null
  );

}
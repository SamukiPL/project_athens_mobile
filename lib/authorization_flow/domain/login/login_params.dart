class LoginParams {

  final String? login;
  final String password;
  final String? email;
  final int cadence;

  LoginParams({this.login, required this.password, this.email, required this.cadence}) : assert(
    login != null || email != null
  );

}
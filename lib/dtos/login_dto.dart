class LoginDto {
  String? email;
  String? password;
  bool? rememberMe;

  LoginDto({this.email, this.password, this.rememberMe = false});
}

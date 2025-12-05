import 'package:fastdx_app/core/core.dart';

class RegisterDto {
  String? name;
  String? email;
  Role role;
  String? password;
  String? confirmPassword;

  RegisterDto({
    this.email,
    this.name,
    this.password,
    this.role = Role.customer,
    this.confirmPassword,
  });

  List<String> get fullName {
    if (name == null) return [''];
    return name!.trim().split(" ");
  }
}

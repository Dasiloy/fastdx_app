import 'package:fastdx_app/core/core.dart';

class CreateProfileDto {
  final String userId;
  final String email;
  final String firstName;
  final String lastName;
  final Role role;

  CreateProfileDto({
    required this.userId,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  Map<String, dynamic> get toMap {
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "role": role.name,
    };
  }
}

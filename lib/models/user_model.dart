import 'package:fastdx_app/core/core.dart';

class AppUser implements EntityInterface {
  @override
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final Role role;

  const AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
  });

  String get name => '$firstName $lastName';

  String get shortName => '$firstName. ${lastName[0]}';

  bool get isVendor => role == Role.vendor;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      role: Role.values.firstWhere((r) => r.name == json["role"]),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'firstName': firstName, 'lastName': lastName};
  }
}

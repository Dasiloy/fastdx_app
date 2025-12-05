import 'package:fastdx_app/core/core.dart';

class RiderInfo implements EntityInterface {
  @override
  final String id;
  final String name;
  final String phone;
  final String avatar;

  const RiderInfo({
    required this.id,
    required this.name,
    required this.phone,
    required this.avatar,
  });

  RiderInfo.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      name = json["name"],
      phone = json["phone"],
      avatar = json["avatar"];

  @override
  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "avatar": avatar,
  };
}

import 'package:fastdx_app/core/core.dart';

class AppResturant implements EntityInterface {
  @override
  final String id;

  final String name;
  final String? image;
  final double ratings;
  final double averageDeliveryTime;
  final double averageDeliveryFee;

  final String? city;
  final String? state;
  final String? street;
  final String? zipCode;
  final double? latitude;
  final double? longitude;
  final String? apartmentNumber;

  const AppResturant({
    required this.id,
    required this.name,
    this.city,
    this.state,
    this.street,
    this.zipCode,
    this.apartmentNumber,
    this.latitude,
    this.longitude,
    this.image,
    this.ratings = 0,
    this.averageDeliveryTime = 0,
    this.averageDeliveryFee = 0,
  });

  factory AppResturant.fromJson(Map<String, dynamic> json) {
    return AppResturant(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      ratings: json["ratings"] ?? 0.00,
      averageDeliveryTime: json["deliveryTime"] ?? 0.00,
      averageDeliveryFee: json["averageDeliveryFee"] ?? 0.00,
      apartmentNumber: json["apartmentNumber"],
      city: json["city"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      state: json["state"],
      street: json["street"],
      zipCode: json["zipCode"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image": image,
      "ratings": ratings,
      "averageDeliveryTime": averageDeliveryTime,
      "averageDeliveryFee": averageDeliveryFee,
    };
  }
}

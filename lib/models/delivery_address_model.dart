import 'package:fastdx_app/core/core.dart';

class OrderDeliveryAddress implements EntityInterface {
  @override
  final String id;
  final String city;
  final String state;
  final String street;
  final String zipCode;
  final double latitude;
  final double longitude;
  final String apartmentNumber;
  final String? deliveryInstructions;

  const OrderDeliveryAddress({
    required this.id,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.latitude,
    required this.longitude,
    required this.apartmentNumber,
    this.deliveryInstructions,
  });

  factory OrderDeliveryAddress.fromJson(Map<String, dynamic> json) {
    return OrderDeliveryAddress(
      id: json["id"],
      street: json["street"],
      city: json["city"],
      state: json["state"],
      zipCode: json["zipCode"],
      apartmentNumber: json["apartmentNumber"],
      deliveryInstructions: json["deliveryInstructions"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "street": street,
      "city": city,
      "state": state,
      "zipCode": zipCode,
      "apartmentNumber": apartmentNumber,
      "deliveryInstructions": deliveryInstructions,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  String get address {
    return 'Apt $apartmentNumber, $street, $city, $state $zipCode';
  }
}

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/models/models.dart';

class AppReview implements EntityInterface {
  @override
  final String id;
  final int rating;
  final String subject;
  final String feedback;
  final DateTime createdAt;

  final AppOrder order;
  final AppUser customer;
  final AppResturant resturant;

  AppReview({
    required this.id,
    required this.subject,
    required this.rating,
    required this.order,
    required this.customer,
    required this.feedback,
    required this.createdAt,
    required this.resturant,
  });

  factory AppReview.fromJson(Map<String, dynamic> json) {
    return AppReview(
      id: json['id'],
      subject: json["subject"],
      rating: json['rating'],
      order: AppOrder.fromJson(json['order']),
      customer: AppUser.fromJson(json['customer']),
      feedback: json['feedback'],
      createdAt: DateTime.parse(json['createdAt']),
      resturant: AppResturant.fromJson(json['resturant']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'rating': rating,
      'order': order.toJson(),
      'feedback': feedback,
      'customer': customer.toJson(),
      'resturant': resturant.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

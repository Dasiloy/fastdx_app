import "package:intl/intl.dart";

import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/models/models.dart';

class AppReview implements EntityInterface {
  @override
  final String id;
  final int rating;
  final String subject;
  final String feedback;
  final DateTime createdAt;

  final AppOrder? order;
  final AppUser? customer;
  final AppResturant? resturant;

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

  String get formattedDate {
    return DateFormat('dd/MM/yyyy').format(createdAt);
  }

  factory AppReview.fromJson(Map<String, dynamic> json) {
    return AppReview(
      id: json['id'],
      rating: json['rating'],
      subject: json["subject"],
      feedback: json['feedback'],
      createdAt: DateTime.parse(json['createdAt']),
      order: json["order"] != null ? AppOrder.fromJson(json['order']) : null,
      customer: json["customer"] != null
          ? AppUser.fromJson(json['customer'])
          : null,
      resturant: json["resturant"] != null
          ? AppResturant.fromJson(json['resturant'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'rating': rating,
      'order': order?.toJson(),
      'feedback': feedback,
      'customer': customer?.toJson(),
      'resturant': resturant?.toJson(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class ReviewAggregate {
  final double average;
  final int count;

  const ReviewAggregate({this.count = 0, this.average = 0});

  String get formattedAverage {
    return average.toStringAsFixed(2);
  }

  @override
  String toString() {
    return '{"count":$count,"average":$average}';
  }
}

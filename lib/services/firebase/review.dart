import "dart:convert";

import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fastdx_app/services/services.dart';
import 'package:fastdx_app/models/review_model.dart';

class ReviewApi {
  static final api = kFireStore.collection("reviews");

  /// dummy method will be removed later
  static Future<void> loadReviews() async {
    try {
      // llad string;
      final String data = await rootBundle.loadString(
        "assets/json/reviews.json",
      );

      // convert to mqp
      final reviews = (json.decode(data) as List<dynamic>)
          .cast<Map<String, dynamic>>();

      final batch = kFireStore.batch();
      for (final review in reviews) {
        final docRef = api.doc();
        batch.set(docRef, review);
      }
      await batch.commit();
    } catch (e) {
      print(e);
    }
  }

  static Future<List<AppReview>> list(ListReviewsParams params) async {
    try {
      Query<Map<String, dynamic>> query = api;

      final customerId = params.customerId;
      final resturantId = params.resturantId;
      final fetchCustomer = params.fetchCustomer;
      final fetchResturant = params.fetchResturant;
      final fetchOrder = params.fetchOrder;

      if (customerId != null) {
        query = query.where("customerId", isEqualTo: customerId);
      }

      if (resturantId != null) {
        query = query.where("resturantId", isEqualTo: resturantId);
      }

      final snaps = await query.get(GetOptions(source: Source.serverAndCache));
      final docs = snaps.docs;

      final reviews = [];

      for (final doc in docs) {
        Map<String, dynamic>? customer;
        Map<String, dynamic>? resturant;
        Map<String, dynamic>? order;

        // --------- FETCH CUSTOMER
        if (fetchCustomer) {
          customer = await ProfileApi.getDoc(doc["customerId"]);
        }

        // --------- FETCH RESTURANT
        if (fetchResturant) {
          resturant = await ResturantApi.getDoc(doc["resturantId"]);
        }

        // --------- FETCH ORDER
        if (fetchOrder) {
          order = await OrderApi.getDoc(doc["orderId"]);
        }

        reviews.add({
          "id": doc.id,
          ...doc.data(),
          "order": order,
          "customer": customer,
          "resturant": resturant,
        });
      }

      return reviews.map((review) {
        return AppReview.fromJson(review);
      }).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<ReviewAggregate> getAggregate(
    ReviewAggregateParams params,
  ) async {
    try {
      Query<Map<String, dynamic>> query = api;

      final customerId = params.customerId;
      final resturantId = params.resturantId;

      if (customerId != null) {
        query = query.where("customerId", isEqualTo: customerId);
      }

      if (resturantId != null) {
        query = query.where("resturantId", isEqualTo: resturantId);
      }

      final aggregates = await query
          .aggregate(count(), average("rating"))
          .get(source: AggregateSource.server);

      return ReviewAggregate(
        count: aggregates.count ?? 0,
        average: aggregates.getAverage("rating") ?? 0,
      );
    } catch (e) {
      print(e);
      return ReviewAggregate();
    }
  }
}

class ListReviewsParams {
  final String? customerId;
  final String? resturantId;
  final bool fetchCustomer;
  final bool fetchResturant;
  final bool fetchOrder;

  ListReviewsParams({
    this.customerId,
    this.resturantId,
    this.fetchCustomer = false,
    this.fetchResturant = false,
    this.fetchOrder = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListReviewsParams &&
        other.customerId == customerId &&
        other.resturantId == resturantId &&
        other.fetchCustomer == fetchCustomer &&
        other.fetchResturant == fetchResturant &&
        other.fetchOrder == fetchOrder;
  }

  @override
  int get hashCode {
    return customerId.hashCode ^
        resturantId.hashCode ^
        fetchCustomer.hashCode ^
        fetchResturant.hashCode ^
        fetchOrder.hashCode;
  }
}

class ReviewAggregateParams {
  final String? customerId;
  final String? resturantId;

  ReviewAggregateParams({this.customerId, this.resturantId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewAggregateParams &&
        other.customerId == customerId &&
        other.resturantId == resturantId;
  }

  @override
  int get hashCode {
    return customerId.hashCode ^ resturantId.hashCode;
  }
}

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

  static Future<List<AppReview>> list({
    String? customerId,
    String? resturantId,
    bool fetchOrder = false,
    bool fetchCustomer = false,
    bool fetchResturant = false,
  }) async {
    try {
      Query<Map<String, dynamic>> query = api;

      if (customerId != null) {
        query.where("customerId", isEqualTo: customerId);
      }

      if (resturantId != null) {
        query.where("resturantId", isEqualTo: resturantId);
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

  static Future<ReviewAggregate> getAggregate({
    String? customerId,
    String? resturantId,
  }) async {
    try {
      Query<Map<String, dynamic>> query = api;

      if (customerId != null) {
        query.where("customerId", isEqualTo: customerId);
      }

      if (resturantId != null) {
        query.where("resturantId", isEqualTo: resturantId);
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

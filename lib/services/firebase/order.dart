import 'dart:convert';

import 'package:fastdx_app/services/firebase/resturant.dart';
import 'package:fastdx_app/services/firebase/rider.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/firebase/meal.dart';
import 'package:fastdx_app/services/firebase/api.dart';
import 'package:fastdx_app/services/firebase/profile.dart';

class OrderApi {
  static final api = kFireStore.collection("orders");

  //. this function will later take a json data as arguement
  static Future<void> post() async {
    try {
      final String json = await rootBundle.loadString("assets/json/order.json");

      final data = ((jsonDecode(json) as List<dynamic>)
          .cast<Map<String, dynamic>>())[0];

      kFireStore.runTransaction((transaction) async {
        // save base order
        final base = Map<String, dynamic>.from(data)
          ..remove("items")
          ..remove("orderDeliveryAddress");
        final orderRef = api.doc();
        transaction.set(orderRef, base);

        // save the Items
        final items = List<Map<String, dynamic>>.from(data["items"]);
        for (final item in items) {
          final itemRef = orderRef.collection("items").doc();
          transaction.set(itemRef, item);
        }

        // save the de;livery address
        final orderDeliveryAddress = Map<String, dynamic>.from(
          data["orderDeliveryAddress"],
        );
        final orderDeliveryAddressRef = orderRef
            .collection("orderDeliveryAddress")
            .doc();
        transaction.set(orderDeliveryAddressRef, orderDeliveryAddress);
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<List<AppOrder>> list({
    String? customerId,
    String? resturantId,
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

      final orders = [];
      for (final doc in docs) {
        Map<String, dynamic>? customer;
        Map<String, dynamic>? resturant;
        // lets fetch the delivery address
        final deliveryAddress = await _getOrderAddress(doc);

        // lets fetch Meal Items
        final items = await _getOrderItems(doc);

        if (fetchCustomer) {
          customer = await ProfileApi.getDoc(doc["customerId"]);
        }

        // --------- FETCH RSTURANT
        if (fetchResturant) {
          resturant = await ResturantApi.getDoc(doc["resturantId"]);
        }

        orders.add({
          "id": doc.id,
          ...doc.data(),
          "customer": customer,
          "resturant": resturant,
          'items': items,
          'orderDeliveryAddress': deliveryAddress,
        });
      }

      return orders.map((order) => AppOrder.fromJson(order)).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<AppOrder?> get({
    required String orderId,
    bool fetchCustomer = false,
    bool fetchResturant = false,
    bool fetchRider = false,
    bool fetchTransaction = false,
  }) async {
    try {
      final data = await getDoc(
        orderId: orderId,
        fetchCustomer: fetchCustomer,
        fetchResturant: fetchResturant,
        fetchRider: fetchRider,
        fetchTransaction: fetchTransaction,
      );
      if (data == null) return null;
      return AppOrder.fromJson(data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getDoc({
    required String orderId,
    bool fetchCustomer = false,
    bool fetchResturant = false,
    bool fetchRider = false,
    bool fetchTransaction = false,
  }) async {
    try {
      final snap = await api.doc(orderId).get();
      if (!snap.exists) return null;
      Map<String, dynamic> doc = {
        "id": snap.id,
        ...snap.data()!,
        "customer": null,
        "resturant": null,
        "rider": null,
        "transaction": null,
      };

      // ---- FETCH ITEMS
      final items = await _getOrderItems(snap);
      doc["items"] = items;

      // ------- DELIVERY ADDRESS
      final deliveryAddress = await _getOrderAddress(snap);
      doc['orderDeliveryAddress'] = deliveryAddress;

      // ------ FETCH CUSTOMER
      if (fetchCustomer) {
        final customer = await ProfileApi.getDoc(doc["customerId"]);
        doc["customer"] = customer;
      }

      // --------- FETCH RSTURANT
      if (fetchResturant) {
        final resturant = await ResturantApi.getDoc(doc["resturantId"]);
        doc["resturant"] = resturant;
      }

      // ---------- FETCH RIDER
      if (fetchRider) {
        final rider = await RiderAPi.getDoc(doc["riderId"]);
        doc["rider"] = rider;
      }

      return doc;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<AppOrder?> update(
    String id,
    Map<String, dynamic> payload,
  ) async {
    try {
      await api.doc(id).update(payload);
      return get(orderId: id);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> _getOrderAddress(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) async {
    try {
      final addressesSnap = await doc.reference
          .collection("orderDeliveryAddress")
          .get();
      final addresses = addressesSnap.docs.map(
        (add) => {...add.data(), "id": add.id},
      );
      return addresses.first;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> _getOrderItems(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) async {
    try {
      final itemsSnap = await doc.reference.collection("items").get();
      List<Map<String, dynamic>> items = itemsSnap.docs
          .map((item) => {...item.data(), "id": item.id})
          .toList();
      final mealFetches = items.map(
        (item) => MealApi.getDoc(mealId: item["mealId"]),
      );

      final meals = await Future.wait(mealFetches, eagerError: true);
      final mealMap = {for (final meal in meals) meal!["id"]: meal};

      return items
          .map((item) => {...item, "meal": mealMap[item["mealId"]]})
          .toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}

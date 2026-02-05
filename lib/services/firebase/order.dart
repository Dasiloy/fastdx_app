import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/core/core.dart';
import 'package:fastdx_app/services/services.dart';

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

  static Future<List<AppOrder>> list(ListOrdersParams params) async {
    try {
      Query<Map<String, dynamic>> query = api;

      final customerId = params.customerId;
      final resturantId = params.resturantId;
      final status = params.status;
      final fetchCustomer = params.fetchCustomer;
      final fetchResturant = params.fetchResturant;

      if (customerId != null) {
        query = query.where("customerId", isEqualTo: customerId);
      }

      if (resturantId != null) {
        query = query.where("resturantId", isEqualTo: resturantId);
      }

      if (status != null) {
        query = query.where("status", isEqualTo: status);
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

  static Future<AppOrder?> get(GetOrderParams params) async {
    try {
      final data = await getDoc(params);
      if (data == null) return null;
      return AppOrder.fromJson(data);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getDoc(GetOrderParams params) async {
    try {
      final orderId = params.orderId;
      final fetchCustomer = params.fetchCustomer;
      final fetchResturant = params.fetchResturant;
      final fetchRider = params.fetchRider;

      final snap = await api
          .doc(orderId)
          .get(GetOptions(source: Source.serverAndCache));
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
      return get(GetOrderParams(orderId: id));
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<OrderAggregates> getOrderAggregates(
    GetOrderAggregatesParams params,
  ) async {
    try {
      Query<Map<String, dynamic>> query = api;

      if (params.customerId != null) {
        query = query.where("customerId", isEqualTo: params.customerId);
      }

      if (params.resturantId != null) {
        query = query.where("resturantId", isEqualTo: params.resturantId);
      }

      AggregateQuerySnapshot? totalSnap;
      AggregateQuerySnapshot? runningSnap;
      AggregateQuerySnapshot? pendingSnap;
      AggregateQuerySnapshot? completedSnap;
      AggregateQuerySnapshot? cancelledSnap;

      final futures = <Future>[];

      // Always fetch total
      futures.add(
        query
            .aggregate(count())
            .get(source: AggregateSource.server)
            .then((value) => totalSnap = value),
      );

      // "Running" = Accepted
      addStatusQuery(
        params.statuses,
        OrderStatusEnum.accepted,
        (v) => runningSnap = v,
        query,
        futures,
      );
      // "Pending" = Pending
      addStatusQuery(
        params.statuses,
        OrderStatusEnum.pending,
        (v) => pendingSnap = v,
        query,
        futures,
      );
      // "Completed" = Completed
      addStatusQuery(
        params.statuses,
        OrderStatusEnum.completed,
        (v) => completedSnap = v,
        query,
        futures,
      );
      // "Cancelled" = Cancelled
      addStatusQuery(
        params.statuses,
        OrderStatusEnum.cancelled,
        (v) => cancelledSnap = v,
        query,
        futures,
      );

      await Future.wait(futures);

      return OrderAggregates(
        totalOrdersCount: totalSnap?.count ?? 0,
        runningOrdersCount: runningSnap?.count ?? 0,
        pendingOrdersCount: pendingSnap?.count ?? 0,
        completedOrdersCount: completedSnap?.count ?? 0,
        cancelledOrdersCount: cancelledSnap?.count ?? 0,
      );
    } catch (e) {
      print(e);
      return OrderAggregates(
        runningOrdersCount: 0,
        pendingOrdersCount: 0,
        completedOrdersCount: 0,
        cancelledOrdersCount: 0,
        totalOrdersCount: 0,
      );
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

  // Helper to add status query
  static void addStatusQuery(
    List<String> statuses,
    OrderStatusEnum status,
    void Function(AggregateQuerySnapshot) onResult,
    Query<Map<String, dynamic>> query,
    List<Future> futures,
  ) {
    if (statuses.contains(status.name)) {
      futures.add(
        query
            .where("status", isEqualTo: status.name)
            .aggregate(count())
            .get(source: AggregateSource.server)
            .then((value) => onResult(value))
            .catchError((e) => print(e)),
      );
    }
  }
}

class ListOrdersParams {
  final String? customerId;
  final String? resturantId;
  final String? status;
  final bool fetchCustomer;
  final bool fetchResturant;

  ListOrdersParams({
    this.customerId,
    this.resturantId,
    this.status,
    this.fetchCustomer = false,
    this.fetchResturant = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListOrdersParams &&
        other.customerId == customerId &&
        other.resturantId == resturantId &&
        other.status == status &&
        other.fetchCustomer == fetchCustomer &&
        other.fetchResturant == fetchResturant;
  }

  @override
  int get hashCode {
    return customerId.hashCode ^
        resturantId.hashCode ^
        status.hashCode ^
        fetchCustomer.hashCode ^
        fetchResturant.hashCode;
  }
}

class GetOrderParams {
  final String orderId;
  final bool fetchCustomer;
  final bool fetchResturant;
  final bool fetchRider;
  final bool fetchTransaction;

  GetOrderParams({
    required this.orderId,
    this.fetchCustomer = false,
    this.fetchResturant = false,
    this.fetchRider = false,
    this.fetchTransaction = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetOrderParams &&
        other.orderId == orderId &&
        other.fetchCustomer == fetchCustomer &&
        other.fetchResturant == fetchResturant &&
        other.fetchRider == fetchRider &&
        other.fetchTransaction == fetchTransaction;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        fetchCustomer.hashCode ^
        fetchResturant.hashCode ^
        fetchRider.hashCode ^
        fetchTransaction.hashCode;
  }
}

class GetOrderAggregatesParams {
  final String? resturantId;
  final String? customerId;
  final List<String> statuses;

  GetOrderAggregatesParams({
    this.resturantId,
    this.customerId,
    List<String>? statuses,
  }) : statuses = statuses ?? [];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetOrderAggregatesParams &&
        other.resturantId == resturantId &&
        other.customerId == customerId &&
        listEquals(other.statuses, statuses);
  }

  @override
  int get hashCode {
    return Object.hash(resturantId, customerId, Object.hashAll(statuses));
  }
}

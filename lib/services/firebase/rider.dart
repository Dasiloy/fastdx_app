import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'package:fastdx_app/models/rider_model.dart';
import 'package:fastdx_app/services/firebase/api.dart';

class RiderAPi {
  static final api = kFireStore.collection("riders");

  static Future<void> loadRiders() async {
    try {
      // load the Json
      final String response = await rootBundle.loadString(
        "assets/json/rider.json",
      );
      final riders = (jsonDecode(response) as List<dynamic>)
          .cast<Map<String, dynamic>>();

      // create batch
      final batch = kFireStore.batch();
      for (final rider in riders) {
        final docRef = api.doc();
        batch.set(docRef, rider);
      }

      await batch.commit();
    } catch (e) {
      print(e);
    }
  }

  static Future<RiderInfo?> get(String id) async {
    try {
      final data = await getDoc(id);
      if (data == null) return null;
      return RiderInfo.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getDoc(String id) async {
    try {
      final snapshot = await api.doc(id).get();
      if (snapshot.exists) {
        final data = snapshot.data();
        return {...data!, "id": snapshot.id};
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

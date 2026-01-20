import "dart:convert";
import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart" show rootBundle;

import "package:fastdx_app/dtos/dtos.dart";
import "package:fastdx_app/models/models.dart";
import "package:fastdx_app/services/firebase/resturant.dart";
import 'package:fastdx_app/services/firebase/api.dart';

class MealApi {
  static final storage = kFireStorage.ref().child("meals");
  static final api = kFireStore.collection('meals');

  // dummy method will be removed later
  static Future<void> loadMeals() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/meal.json',
      );

      final meals = (json.decode(response) as List<dynamic>)
          .cast<Map<String, dynamic>>();

      final batch = kFireStore.batch();

      for (final meal in meals) {
        final docRef = api.doc();
        batch.set(docRef, meal);
      }

      await batch.commit();
    } catch (e) {
      print(e);
    }
  }

  static Future<void> post(MealDto data) async {
    try {
      data.image = await upload(name: data.name, file: data.file!);
      final docRef = api.doc();
      await docRef.set(data.toMap());
    } on FirebaseException catch (e, st) {
      debugPrint("Storage error: ${e.code} - ${e.message}\n$st");
      rethrow;
    } catch (e, st) {
      debugPrint("Unknown error posting meal: $e\n$st");
      rethrow;
    }
  }

  static Future<List<AppMeal>> list(ListMealsParams? params) async {
    final plain = params?.plain ?? true;
    final resturantId = params?.resturantId;
    final category = params?.category;

    try {
      Query<Map<String, dynamic>> query = api;

      if (resturantId != null) {
        query = query.where("resturantId", isEqualTo: resturantId);
      }

      if (category != null) {
        query = query.where("category", isEqualTo: category);
      }

      final snaps = await query.get(GetOptions(source: Source.serverAndCache));
      List<Map<String, dynamic>> meals = snaps.docs.map((doc) {
        return {...doc.data(), "id": doc.id};
      }).toList();

      if (!plain) {
        // set of ResturantId,
        final resturantIds = meals
            .map((meal) => meal["resturantId"] as String)
            .toSet();

        final resturantFetches = resturantIds.map(
          (resturantId) => ResturantApi.api.doc(resturantId).get(),
        );

        // Fetch all resturants
        final resturants = await Future.wait(
          resturantFetches,
          eagerError: true,
        );

        // resturant maps
        final returantMap = {
          for (final resturant in resturants)
            resturant.id: {...resturant.data()!, "id": resturant.id},
        };

        // attach resturant data to meals
        meals = meals
            .map(
              (meal) => {
                ...meal,
                "resturant": returantMap[meal["resturantId"]],
              },
            )
            .toList();
      }

      return meals.map((data) => AppMeal.fromJson(data)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<AppMeal?> get({
    bool plain = true,
    required String mealId,
  }) async {
    try {
      final data = await getDoc(mealId: mealId, plain: plain);
      if (data == null) return null;
      return AppMeal.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getDoc({
    bool plain = true,
    required String mealId,
  }) async {
    try {
      final snap = await api.doc(mealId).get();

      if (snap.exists) {
        Map<String, dynamic> doc = {...snap.data()!, "id": snap.id};
        if (!plain) {
          final resturantSnap = await ResturantApi.api
              .doc(doc["resturantId"])
              .get();
          if (resturantSnap.exists) {
            doc = {
              ...doc,
              "resturant": {...resturantSnap.data()!, "id": resturantSnap.id},
            };
          }
        }

        return doc;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<AppMeal?> update(
    String id,
    Map<String, dynamic> payload, {
    bool plain = true,
  }) async {
    try {
      if (payload["image"] != null) {
        await deleteImage(payload["image"]!);
      }

      if (payload["file"] != null) {
        payload["image"] = await upload(
          name: payload["name"]!,
          file: payload["file"]!,
        );
      }

      await api.doc(id).update(payload);
      return get(mealId: id, plain: plain);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> delete(String id) async {
    try {
      await api.doc(id).delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<void> deleteImage(String imageUrl) async {
    try {
      final ref = storage.child(imageUrl);
      await ref.delete();
    } catch (e) {
      print(e);
    }
  }

  static Future<String> upload({
    required String name,
    required File file,
  }) async {
    final ref = storage.child(MealApi._getFileName(name));
    await ref.putData(await file.readAsBytes());
    final downloadUrl = await ref.getDownloadURL();

    return downloadUrl;
  }

  static String _getFileName(String name) =>
      "${DateTime.now().millisecondsSinceEpoch}$name.jpg";
}

///  Define query parameters
class ListMealsParams {
  final bool plain;
  final String? resturantId;
  final String? category;

  ListMealsParams({this.plain = true, this.resturantId, this.category});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListMealsParams &&
        other.plain == plain &&
        other.resturantId == resturantId &&
        other.category == category;
  }

  @override
  int get hashCode => plain.hashCode ^ resturantId.hashCode ^ category.hashCode;
}

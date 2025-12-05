import 'package:fastdx_app/dtos/dtos.dart';
import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/firebase/api.dart';

class ResturantApi {
  static final api = kFireStore.collection("resturants");

  static Future<AppResturant?> post(CreateResturantDto data) async {
    try {
      await api.doc(data.id).set(data.toMap);
      return AppResturant(id: data.id, name: data.name);
    } catch (e) {
      return null;
    }
  }

  static Future<AppResturant?> get(String id) async {
    try {
      final data = await getDoc(id);
      if (data == null) return null;
      return AppResturant.fromJson(data);
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

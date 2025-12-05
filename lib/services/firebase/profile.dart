import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/dtos/dtos.dart';
import 'package:fastdx_app/services/firebase/api.dart';

class ProfileApi {
  static final api = kFireStore.collection('profiles');

  static Future<AppUser?> post(CreateProfileDto data) async {
    await api.doc(data.userId).set(data.toMap);
    return AppUser(
      id: data.userId,
      firstName: data.firstName,
      lastName: data.lastName,
      email: data.email,
      role: data.role,
    );
  }

  static Future<AppUser?> get(String userId) async {
    try {
      final data = await getDoc(userId);
      if (data == null) return null;
      return AppUser.fromJson(data);
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getDoc(String userId) async {
    try {
      final snapshot = await api.doc(userId).get();
      if (snapshot.exists) {
        final data = snapshot.data()!;
        return {...data, 'id': snapshot.id};
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

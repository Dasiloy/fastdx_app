import 'package:fastdx_app/dtos/dtos.dart';
import 'package:fastdx_app/services/firebase/api.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  static Future<void> logout() async {
    try {
      await kFireAuth.signOut();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<UserCredential> login(LoginDto data) async {
    try {
      UserCredential userCredentials = await kFireAuth
          .signInWithEmailAndPassword(
            email: data.email!,
            password: data.password!,
          );
      return userCredentials;
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  static Future<dynamic> register(RegisterDto data) async {
    try {
      UserCredential credentials = await kFireAuth
          .createUserWithEmailAndPassword(
            email: data.email!,
            password: data.password!,
          );
      return credentials;
    } catch (error) {
      print(error);
      rethrow;
    }
  }
}

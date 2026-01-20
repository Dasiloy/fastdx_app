import "dart:async";

import 'package:flutter_riverpod/legacy.dart';
import "package:sqflite/sqlite_api.dart";

import 'package:fastdx_app/models/models.dart';
import 'package:fastdx_app/services/services.dart';

class AppProviderNotifier extends StateNotifier<AppState> {
  Database? _database;

  AppProviderNotifier() : super(AppState.initState());

  Future<void> _initDb() async {
    _database ??= await Db.createDb();
  }

  Future<Database> get database async {
    if (_database == null) {
      await _initDb();
    }
    return _database!;
  }

  Future<void> load() async {
    state = state.copyWith(loading: true);
    try {
      // instantiate variables
      AppUser? user;
      AppResturant? resturant;

      final isLoggedIn = kFireAuth.currentUser != null;

      if (isLoggedIn) {
        final profile = await ProfileApi.get(kFireAuth.currentUser!.uid);
        if (profile != null) {
          user = profile;
          if (user.isVendor) {
            resturant = await ResturantApi.get(user.id);
          }
        }
      }

      // we wiull remove this later
      // await Storage.setOnboarded(false);

      // do some persisted data fetch
      // query sqflite for stored carts and all;
      //  final db = await database;

      state = AppState.initializeApp(user: user, resturant: resturant);
    } catch (e) {
      state = AppState.initState();
    }
  }

  Future<void> completeOnboarding() async {
    state = await state.markOnboarded();
  }

  void setProfile({AppUser? user, AppResturant? resturant}) {
    state = state.copyWith(user: user, resturant: resturant);
  }

  void clear() {
    state = AppState.initState().copyWith(loading: false);
  }
}

final appProvider = StateNotifierProvider<AppProviderNotifier, AppState>(
  (ref) => AppProviderNotifier(),
);

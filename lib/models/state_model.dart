import 'package:fastdx_app/models/models.dart';
import "package:fastdx_app/services/services.dart";

class AppState {
  final AppUser? user;
  final AppResturant? resturant;
  final bool _onboarded;
  final bool loading;

  bool get onboarded => _onboarded;

  AppState._({
    this.user,
    required this.loading,
    required bool onboarded,
    this.resturant,
  }) : _onboarded = onboarded;

  factory AppState.initState() {
    return AppState._(
      user: null,
      onboarded: Storage.hasOnboarded,
      loading: true,
      resturant: null,
    );
  }

  factory AppState.initializeApp({AppUser? user, AppResturant? resturant}) {
    return AppState._(
      user: user,
      onboarded: Storage.hasOnboarded,
      loading: false,
      resturant: resturant,
    );
  }

  AppState copyWith({AppUser? user, AppResturant? resturant, bool? loading}) {
    return AppState._(
      onboarded: _onboarded,
      user: user ?? this.user,
      loading: loading ?? this.loading,
      resturant: resturant ?? this.resturant,
    );
  }

  Future<AppState> markOnboarded() async {
    await Storage.setOnboarded(true);
    return AppState._(user: user, onboarded: true, loading: false);
  }
}

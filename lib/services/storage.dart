import "package:shared_preferences/shared_preferences.dart";

import "package:fastdx_app/constants/constants.dart";

class Storage {
  static late final SharedPreferencesWithCache _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{kOnboardingKey, kRememberMe},
      ),
    );
  }

  static Future<void> setOnboarded(bool value) async {
    await _prefs.setBool(kOnboardingKey, value);
  }

  static Future<void> setRememberMe(String value) async {
    await _prefs.setString(kRememberMe, value);
  }

  static String get rememberMe {
    return _prefs.getString(kRememberMe) ?? "";
  }

  static bool get hasOnboarded {
    return _prefs.getBool(kOnboardingKey) ?? false;
  }
}

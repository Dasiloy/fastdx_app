import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:fastdx_app/core/core.dart';
import "package:fastdx_app/services/services.dart";
import 'package:fastdx_app/theme/theme.dart';
import 'package:fastdx_app/screens/screens.dart';
import 'package:fastdx_app/constants/constants.dart';
import "package:fastdx_app/firebase_options.dart";
import 'package:fastdx_app/providers/providers.dart';
import 'package:fastdx_app/screens/auth/login/login_screen.dart';

/**
 * 
 * BUILD NOTIFICATIONS SCREEN
 * BUILD CHAT SCREEN
 * BUILD PROFILE PAGES
 * 
 */
Future<void> main() async {
  // ENsure Native Code and flutter binding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Persist splash screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Load Env Vars
  await dotenv.load(fileName: ".env");

  // Init SharedPreferencesWithCache
  await Storage.init();

  // Init Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Set up RiverPods Provider around the app
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    initApp();
  }

  Future<void> initApp() async {
    // app initialization
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(appProvider.notifier).load();
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasOnboarded = ref.watch(appProvider).onboarded;
    final user = ref.watch(appProvider).user;
    final loading = ref.watch(appProvider).loading;

    return MaterialApp(
      title: kAppName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: !hasOnboarded
          ? OnboardingScreen()
          : StreamBuilder(
              stream: kFireAuth.authStateChanges(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    loading) {
                  return Container(
                    color: Theme.of(ctx).colorScheme.surface,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (!snapshot.hasData) {
                  return LoginScreen();
                }

                if (user == null) {
                  return LoginScreen();
                }

                if (user.role == Role.customer) {
                  return CustomerHomeScreen();
                }

                return VendorHomeScreen();
              },
            ),
    );
  }
}

part of "login_screen.dart";

abstract class _Controller extends ConsumerState<LoginScreen> {
  final _key = GlobalKey<FormState>();
  bool _loading = false;
  final data = LoginDto();

  @override
  void initState() {
    super.initState();
    data.email = Storage.rememberMe;
  }

  final validateEmail = MultiValidator([
    RequiredValidator(errorText: "Email is required"),
    EmailValidator(errorText: "Email is Invalid"),
  ]);

  final validatePassword = MultiValidator([
    RequiredValidator(errorText: "Password is required"),
  ]);

  Future<void> _onLogin() async {
    AppUser? profile;
    AppResturant? resturant;
    final validated = _key.currentState?.validate();
    if (validated != true) {
      return;
    }
    _key.currentState?.save();
    setState(() {
      _loading = true;
    });

    try {
      final userCredentials = await kFireAuth.signInWithEmailAndPassword(
        email: data.email!,
        password: data.password!,
      );

      profile = await ProfileApi.get(userCredentials.user!.uid);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        setState(() {
          _loading = false;
        });

        if (profile != null && profile.isVendor) {
          resturant = await ResturantApi.get(profile.id);
        }

        ref
            .read(appProvider.notifier)
            .setProfile(user: profile, resturant: resturant);

        if (data.rememberMe!) {
          await Storage.setRememberMe(data.email!);
        } else {
          await Storage.setRememberMe("");
        }
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _loading = false;
      });
      if (!mounted) return;
      switch (e.code) {
        case 'user-not-found':
          Notify.showError(
            context: context,
            message: 'No user found for that email.',
          );
          break;

        case 'wrong-password':
          Notify.showError(
            context: context,
            message: 'Wrong password provided for that user.',
          );
          break;

        case 'invalid-credential':
          Notify.showError(
            context: context,
            message: 'Email or Password Incorrect!',
          );
          break;

        default:
          Notify.showError(context: context, message: "An error occured");
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      if (!mounted) return;
      Notify.showError(context: context, message: "An error occured");
    }
  }
}

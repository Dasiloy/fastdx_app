part of "register_screen.dart";

abstract class _Controller extends ConsumerState<RegisterScreen> {
  final data = RegisterDto();
  bool _loading = false;
  final _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController(text: "");

  final validateName = MultiValidator([
    RequiredValidator(errorText: "Name is required"),
    MinLengthValidator(5, errorText: "Name is too short"),
  ]);

  final validateEmail = MultiValidator([
    RequiredValidator(errorText: "Email is required"),
    EmailValidator(errorText: "Email is invalid"),
  ]);

  final validatePassword = MultiValidator([
    RequiredValidator(errorText: "Password is required"),
    MinLengthValidator(
      8,
      errorText: "Password must be at least 8 characters long!",
    ),

    //  Must contain at least one number
    PatternValidator(
      r'(?=.*\d)',
      errorText: "Must contain at least one number",
    ),

    //  Must contain uppercase and lowercase letters
    PatternValidator(
      r'(?=.*[A-Z])',
      errorText: "Must contain at least one uppercase letter",
    ),
    PatternValidator(
      r'(?=.*[a-z])',
      errorText: "Must contain at least one lowercase letter",
    ),

    //  Must contain a special character
    PatternValidator(
      r'(?=.*[@$!%*?&])',
      errorText: "Must contain at least one special character",
    ),
  ]);

  String? validateConfirmPassword(String? confirmPassword) {
    final error = MultiValidator([
      RequiredValidator(errorText: "Confirm password is required"),
    ]).call(confirmPassword);

    if (error != null) return error;

    return MatchValidator(
      errorText: "Passwords do not match",
    ).validateMatch(confirmPassword!, _passwordController.text);
  }

  Future<void> _onRegister() async {
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
      UserCredential credentials = await kFireAuth
          .createUserWithEmailAndPassword(
            email: data.email!,
            password: data.password!,
          );

      profile = await ProfileApi.post(
        CreateProfileDto(
          role: data.role,
          userId: credentials.user!.uid,
          email: data.email!,
          firstName: data.fullName[0],
          lastName: data.fullName[1],
        ),
      );

      if (profile != null && profile.isVendor) {
        resturant = await ResturantApi.post(
          CreateResturantDto(name: profile.name, id: profile.id),
        );
      }
      ref
          .read(appProvider.notifier)
          .setProfile(user: profile, resturant: resturant);

      setState(() {
        _loading = false;
      });

      if (!mounted) return;
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        _loading = false;
      });
      if (!mounted) return;
      switch (e.code) {
        case "email-already-in-use":
          Notify.showError(
            context: context,
            message: "This email is already registered.",
          );
          break;

        case "invalid-email":
          Notify.showError(
            context: context,
            message: "The email address is invalid.",
          );
          break;

        case "weak-password":
          Notify.showError(
            context: context,
            message: "The password is too weak.",
          );
          break;

        case "operation-not-allowed":
          Notify.showError(
            context: context,
            message: "You are not allowed to use this service!",
          );
          break;

        case "too-many-requests":
          Notify.showError(
            context: context,
            message: "Too many attempts. Try again later.",
          );
          break;

        case "network-request-failed":
          Notify.showError(
            context: context,
            message: "Please check your internet connection.",
          );
          break;

        default:
          Notify.showError(
            context: context,
            message: "An error ocuured!. Please try again later",
          );
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

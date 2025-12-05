part of 'forgot_password_screen.dart';

abstract class _Controller extends State<ForgotPasswordScreen> {
  String _email = "";
  bool _loading = false;
  final _key = GlobalKey<FormState>();

  final validateEmail = MultiValidator([
    RequiredValidator(errorText: "Email is required"),
    EmailValidator(errorText: "Email is invalid"),
  ]);

  Future<void> _onForgotPassword() async {
    final validated = _key.currentState!.validate();
    if (!validated) return;
    _key.currentState!.save();

    setState(() {
      _loading = true;
    });

    try {
      await kFireAuth.sendPasswordResetEmail(
        email: _email,
        //  actionCodeSettings: ActionCodeSettings(url: url)
      );

      if (!mounted) return;
      setState(() {
        _loading = false;
      });

      Notify.showError(context: context, message: "Email reset link sent");
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });

      Notify.showError(
        context: context,
        message: e.message ?? "An error occured!",
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });

      Notify.showError(context: context, message: "An error occured!");
    }
  }
}

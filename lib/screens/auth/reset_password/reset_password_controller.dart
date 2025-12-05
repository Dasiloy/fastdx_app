part of "reset_password_screen.dart";

abstract class _Controller extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  late int _time;
  late CountDown _countDown;

  @override
  void initState() {
    super.initState();
    _time = 59;
    _countDown = CountDown(
      duration: _time,
      onTick: (timeLeft) {
        setState(() {
          _time = timeLeft;
        });
      },
      onFinish: () {
        setState(() {
          _time = 0;
        });
      },
    );
    _countDown.start();
  }

  @override
  void dispose() {
    _countDown.stop();
    super.dispose();
  }

  Future<void> _onVerifyOtp() async {
    // we will do some auth to verify the user here

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return LoginScreen();
        },
      ),
    );
  }
}

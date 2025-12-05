import 'dart:async';

class CountDown {
  final int duration;
  int _remainingTime = 0;
  Timer? _timer;

  final void Function(int timeLeft) _onTick;

  final void Function()? _onFinish;

  CountDown({required this.duration, required onTick, required onFinish})
    : _remainingTime = duration,
      _onFinish = onFinish,
      _onTick = onTick;

  void start() {
    // reset the old timer
    _timer?.cancel();
    _remainingTime = duration;
    _onTick(_remainingTime);

    // lets start the CountDown
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // subtract 1 from remaining time for every 1 sec
      _remainingTime--;

      if (_remainingTime > 0) {
        _onTick(_remainingTime);
      } else {
        timer.cancel();
        _onFinish?.call();
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }
}

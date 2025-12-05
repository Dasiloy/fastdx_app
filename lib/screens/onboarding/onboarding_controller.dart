part of "onboarding_screen.dart";

abstract class _Controller extends ConsumerState<OnboardingScreen> {
  int _index = 0;
  final _controller = PageController(initialPage: 0);

  bool get _isLast {
    return _index == 2;
  }

  String get _nextLabel {
    if (_isLast) {
      return "Get Started";
    }
    return "Next";
  }

  _onChangeIndex(index) {
    setState(() {
      _index = index;
    });
  }

  _onDotClicked(index) {
    _onChangeIndex(index);
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  _onNextClicked() {
    if (!_isLast) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      ref.read(appProvider.notifier).completeOnboarding();
    }
  }

  _onSkipClicked() {
    ref.read(appProvider.notifier).completeOnboarding();
  }
}

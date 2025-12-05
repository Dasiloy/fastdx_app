import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";

import "package:fastdx_app/widgets/widgets.dart";
import "package:fastdx_app/providers/providers.dart";
import "package:fastdx_app/models/models.dart";

part "onboarding_controller.dart";

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() {
    return _State();
  }
}

class _State extends _Controller {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(bottom: 40, left: 24, right: 24),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: _onChangeIndex,
                scrollDirection: Axis.horizontal,
                children: const [
                  Onboarding(
                    data: Onbaord(
                      title: "All your favorites",
                      description:
                          "Get all your loved foods in one once place,you just place the orer we do the rest",
                      imageUrl: "assets/images/onboarding_1.png",
                    ),
                  ),
                  Onboarding(
                    data: Onbaord(
                      title: 'Order from choosen chef',
                      description:
                          "Get all your loved foods in one once place,you just place the orer we do the rest",
                      imageUrl: "assets/images/onboarding_1.png",
                    ),
                  ),
                  Onboarding(
                    data: Onbaord(
                      title: "Free delivery offers",
                      description:
                          "Get all your loved foods in one once place,you just place the orer we do the rest",
                      imageUrl: "assets/images/onboarding_1.png",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SmoothPageIndicator(
              count: 3,
              controller: _controller,
              onDotClicked: _onDotClicked,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Theme.of(context).colorScheme.primaryContainer,
                activeDotColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 69),
            PrimaryButton(label: _nextLabel, onPressed: _onNextClicked),
            const SizedBox(height: 16),
            if (!_isLast)
              TertiaryButton(label: "Skip", onPressed: _onSkipClicked)
            else
              SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

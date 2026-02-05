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
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
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
                          "Discover a wide variety of delicious meals from top local restaurants, all in one place.",
                      imageUrl: "assets/images/onboarding_1.png",
                    ),
                  ),
                  Onboarding(
                    data: Onbaord(
                      title: 'Expert Chefs',
                      description:
                          "Order from the best. Our meals are crafted by renowned chefs to ensure every bite is perfect.",
                      imageUrl: "assets/images/onboarding_2.png",
                    ),
                  ),
                  Onboarding(
                    data: Onbaord(
                      title: "Fast & Free Delivery",
                      description:
                          "Enjoy lightning-fast delivery to your doorstep. Hot, fresh, and hassle-free.",
                      imageUrl: "assets/images/onboarding_3.png",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(
                label: _nextLabel,
                onPressed: _onNextClicked,
              ),
            ),
            const SizedBox(height: 16),
            if (!_isLast)
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                ),
                child: TertiaryButton(label: "Skip", onPressed: _onSkipClicked),
              )
            else
              SizedBox(height: 50 + MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }
}

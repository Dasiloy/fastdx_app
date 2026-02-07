import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import "package:fastdx_app/widgets/widgets.dart";
import 'package:fastdx_app/helpers/helpers.dart';
import 'package:fastdx_app/screens/screens.dart';
import 'package:fastdx_app/providers/providers.dart';
import 'package:fastdx_app/services/firebase/firebasde.dart';

class VendorProfileScreen extends ConsumerWidget {
  const VendorProfileScreen({super.key});

  void _logOut(BuildContext ctx, WidgetRef ref) async {
    try {
      await AuthApi.logout();
      if (ctx.mounted) {
        Navigator.of(ctx).pop();
      }
      ref.read(appProvider.notifier).clear();
    } catch (error) {
      if (!ctx.mounted) return;
      Notify.showError(
        context: ctx,
        message: "An error occured!. Please try again later",
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isAndroid = Platform.isAndroid;

    return Material(
      child: Container(
        color: Utils.isLightMode(context)
            ? Theme.of(context).colorScheme.surfaceContainerLowest
            : Theme.of(context).scaffoldBackgroundColor,
        child: CustomScrollView(
          slivers: [
            // AppBar
            SliverAppBar(
              pinned: true,
              expandedHeight: 280,
              centerTitle: !isAndroid,
              title: Text("My Profile"),
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              // FlexibleSpaceBar
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.9),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top + 20,
                        ),
                        child: Column(
                          spacing: 0,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Available Balance",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              NumberFormat.currency(
                                locale: "en_US",
                                symbol: "\$",
                                decimalDigits: 2,
                              ).format(500.00),
                              style: Theme.of(context).textTheme.displayLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(height: 20),

                            AppTextButton(
                              enableFeedback: false,
                              onPress: () {},
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 18,
                              ),
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(color: Colors.white),
                              label: "Withdraw",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //  BODY
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 20,
                  ),
                  child: Column(
                    spacing: 20,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // PROFILE SECTION
                      ProfileCard(
                        child: Column(
                          spacing: 16,
                          children: [
                            // ITEM
                            ProfileItem(
                              iconUrl: "assets/icons/user.svg",
                              label: "Personal Info",
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => EditProfileScreen(),
                                  ),
                                );
                              },
                            ),
                            // ITEM
                          ],
                        ),
                      ),

                      // PROFILE SECTION
                      ProfileCard(
                        child: Column(
                          spacing: 16,
                          children: [
                            // ITEM
                            ProfileItem(
                              iconUrl: "assets/icons/withdrawal.svg",
                              label: "Withdrawal Histrory",
                              onTap: () {},
                            ),
                            // ITEM
                            ProfileItem(
                              iconUrl: "assets/icons/reviews.svg",
                              label: "User Reviews",
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => VendorReviewsScreen(),
                                  ),
                                );
                              },
                            ),
                            ProfileItem(
                              iconUrl: "assets/icons/faq.svg",
                              label: "FAQ",
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),

                      // PROFILE SECTION
                      ProfileCard(
                        child: Column(
                          spacing: 16,
                          children: [
                            // ITEM
                            ProfileItem(
                              iconUrl: "assets/icons/settings.svg",
                              label: "Settings",
                              onTap: () {},
                            ),
                            // ITEM
                            ProfileItem(
                              icon: const SizedBox.shrink(),
                              iconUrl: "assets/icons/logout.svg",
                              label: "Log Out",
                              onTap: () {
                                _logOut(context, ref);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

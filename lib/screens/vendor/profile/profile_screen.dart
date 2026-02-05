import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/theme/theme.dart';
import "package:fastdx_app/widgets/widgets.dart";
import 'package:fastdx_app/helpers/helpers.dart';

class VendorProfileScreen extends ConsumerWidget {
  const VendorProfileScreen({super.key});
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
              pinned: false,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // PROFILE SECTION
                      ProfileCard(
                        child: Column(
                          spacing: 16,
                          children: [
                            // ITEM
                            GestureDetector(
                              onTap: () {
                                print("Tapped");
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // HEAD
                                  Expanded(
                                    child: Row(
                                      spacing: 13,
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Utils.isLightMode(context)
                                                ? Colors.white
                                                : AppColors.containerDark,
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              "assets/icons/user.svg",
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Personal Info",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),

                                  Icon(
                                    Icons.chevron_right,
                                    size: 24,
                                    color: Theme.of(
                                      context,
                                    ).iconTheme.color?.withValues(alpha: 0.5),
                                  ),
                                ],
                              ),
                            ),
                            //ITEM
                            GestureDetector(
                              onTap: () {
                                print("Tapped");
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // HEAD
                                  Expanded(
                                    child: Row(
                                      spacing: 13,
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Utils.isLightMode(context)
                                                ? Colors.white
                                                : AppColors.containerDark,
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              "assets/icons/address.svg",
                                              width: 18,
                                              height: 18,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "Addresses",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),

                                  Icon(
                                    Icons.chevron_right,
                                    size: 24,
                                    color: Theme.of(
                                      context,
                                    ).iconTheme.color?.withValues(alpha: 0.5),
                                  ),
                                ],
                              ),
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

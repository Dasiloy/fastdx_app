import 'package:flutter/material.dart';

import "package:fastdx_app/models/models.dart";

class Onboarding extends StatelessWidget {
  final Onbaord data;

  const Onboarding({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image.asset(
          data.imageUrl,
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          fit: BoxFit.cover,
          // color: Theme.of(context).colorScheme.primary,
        ),
        // const SizedBox(height: 63),
        Text(
          data.title,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 18),
        Text(
          data.description,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

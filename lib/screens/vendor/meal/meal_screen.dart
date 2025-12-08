import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fastdx_app/models/models.dart';

part 'meal_controller.dart';

class VendorMealScreen extends Controller {
  const VendorMealScreen({super.key, required super.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: CustomScrollView(
        slivers: [
          // AppBar
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            title: Text(meal.name),
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit_outlined, color: Colors.white, size: 26),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: meal.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Image.network(meal.image, fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black54,
                          Colors.black45,
                          Colors.black38,
                          Colors.black45,
                          Colors.black87,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        meal.buildMaterialChip(context),
                        Text(
                          meal.formattedPrice,
                          style: Theme.of(context).textTheme.headlineLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 20,
                  vertical: 13,
                ),
                child: Column(
                  children: [
                    Row(children: [Text(meal.name)]),
                    Row(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

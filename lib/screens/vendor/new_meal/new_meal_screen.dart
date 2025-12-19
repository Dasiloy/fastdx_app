import "package:flutter/material.dart";

part 'new_meal_controller.dart';

class VendorNewMealScreen extends StatefulWidget {
  const VendorNewMealScreen({super.key});

  @override
  State<VendorNewMealScreen> createState() {
    return _State();
  }
}

class _State extends _Controller {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar());
  }
}

import "package:flutter/material.dart";

part 'edit_meal_controller.dart';

class VendorEditMealScreen extends StatefulWidget {
  const VendorEditMealScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends _Controller {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar());
  }
}

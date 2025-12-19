import 'package:flutter/material.dart';

class PopMenuModel<T> {
  final String label;
  final T value;
  final Widget? icon;

  const PopMenuModel({required this.label, required this.value, this.icon});
}

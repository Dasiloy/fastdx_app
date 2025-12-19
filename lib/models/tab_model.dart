import 'package:flutter/material.dart';
import 'package:fastdx_app/helpers/helpers.dart';

class AppTab<T> {
  final String label;
  final T value;
  final Widget Function(T value, String label, BuildContext context) build;

  AppTab({required this.label, required this.value, required this.build});

  String get formattedLabel {
    return Utils.getFormattedStringFromCamelCase(label);
  }
}

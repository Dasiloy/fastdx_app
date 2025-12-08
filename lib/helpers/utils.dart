import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Utils {
  static double getDeviceHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getDeviceWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static bool isLightMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.light;
  }

  static String getFormattedStringFromCamelCase(String camelCase) {
    if (camelCase.isEmpty) return '';

    // Insert space before uppercase letters and convert to lowercase
    String result = camelCase
        .replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match.group(0)}')
        .trim();

    // Capitalize first letter of each word
    return result
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        })
        .join(' ');
  }

  static String formatDate(DateTime date) {
    final day = date.day;
    final daySuffix = _daySuffix(day);
    final monthYear = DateFormat('MMMM yyyy').format(date);
    final time = DateFormat('HH:mm').format(date);

    return '$day$daySuffix $monthYear, $time';
  }

  static String _daySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}

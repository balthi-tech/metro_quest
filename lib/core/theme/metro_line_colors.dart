import 'package:flutter/material.dart';

class MetroLineColors {
  static const Map<String, int> lineColorMap = {
    '1': 0xFFFFCE00,
    '2': 0xFF0064B0,
    '3': 0xFF9F9825,
    '3B': 0xFF98D4E2,
    '4': 0xFFC04191,
    '5': 0xFFF28E42,
    '6': 0xFF83C491,
    '7': 0xFFF3A4BA,
    '7B': 0xFF83C491,
    '8': 0xFFCEADD2,
    '9': 0xFFD5C900,
    '10': 0xFFE3B32A,
    '11': 0xFF8D5E2A,
    '12': 0xFF00814F,
    '13': 0xFF98D4E2,
    '14': 0xFF662483,
    // '15': 0xFFB90845,
    // '16': 0xFFF3A4BA,
    // '17': 0xFFD5C900,
    // '18': 0xFF00A88F,
  };

  static Color getColorForLine(String lineId) {
    final colorValue = lineColorMap[lineId];
    if (colorValue != null) {
      return Color(colorValue);
    } else {
      return Colors.grey; // Default color if lineId not found
    }
  }

  static double getColorHueForLine(String lineId) {
    final colorValue = lineColorMap[lineId];
    if (colorValue != null) {
      final color = getColorForLine(lineId);

      final hslColor = HSLColor.fromColor(color);

      return hslColor.hue;
    } else {
      return 0.0; // Default hue if lineId not found
    }
  }
}

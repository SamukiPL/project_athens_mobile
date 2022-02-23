import 'package:flutter/material.dart';

class ChartColorManager {
  final Map<String, Color> usedColorsForKeys = Map<String, Color>();

  final int _nextShadeNumber = 300;

  final List<MaterialColor> _colors = [
    Colors.blue,
    Colors.pink,
    Colors.amber,
    Colors.deepPurple,
    Colors.green,
    Colors.brown,
    Colors.red,
    Colors.teal,
    Colors.purple,
    Colors.cyan
  ];

  int _currentColorIdx = 0;
  int _currentShadeIdx = 100;

  Color getColorForKey(String key) {
    if (usedColorsForKeys.containsKey(key)) {
      return usedColorsForKeys[key]!;
    } else {
      final newColor = _getNextColor();

      usedColorsForKeys.putIfAbsent(key, () => newColor);

      return newColor;
    }
  }

  Color _getNextColor() {
    if (_currentShadeIdx == 700) {
      _currentShadeIdx = 100;
      _currentColorIdx++;
    }

    if (_currentColorIdx >= _colors.length) {
      _currentColorIdx = 0;
    }

    final palette = _colors[_currentColorIdx];
    _currentShadeIdx += _nextShadeNumber;
    final colorShade = palette[_currentShadeIdx];

    return colorShade!;
  }
}
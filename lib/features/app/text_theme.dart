import 'package:flutter/material.dart';

class AppTextTheme extends TextTheme {
  const AppTextTheme()
      : super(
          bodySmall: _bodySmall,
          bodyMedium: _bodyMedium,
          bodyLarge: _bodyLarge,
        );

  static const TextStyle _bodySmall = TextStyle(
    color: _color,
    fontSize: 18,
  );

  static const TextStyle _bodyMedium = TextStyle(
    color: _color,
    fontSize: 20,
  );

  static const TextStyle _bodyLarge = TextStyle(
    color: _color,
    fontSize: 24,
  );

  static const Color _color = Colors.white;
}

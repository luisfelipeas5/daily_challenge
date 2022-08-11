import 'package:daily_challenge/shared/widgets/solid_shadow_card/solid_shadow_card.dart';
import 'package:flutter/material.dart';

class PrimarySolidShadowCard extends SolidShadowCard {
  PrimarySolidShadowCard({
    super.key,
    required super.backgroundHeight,
    required super.width,
    super.animate,
    Widget? child,
  }) : super(
          backgroundDecoration: _backgroundDecoration,
          shadowColor: _shadowColor,
          child: child,
        );

  static final BoxDecoration _backgroundDecoration = BoxDecoration(
    gradient: _gradient,
    border: Border.all(
      color: const Color.fromRGBO(33, 80, 227, 1),
      width: 2,
    ),
  );

  static const LinearGradient _gradient = LinearGradient(
    colors: [
      Color.fromRGBO(33, 80, 227, 1),
      Color.fromRGBO(34, 96, 255, 1),
    ],
  );

  static const Color _shadowColor = Color.fromRGBO(11, 45, 141, 1);
}

import 'package:daily_challenge/shared/widgets/solid_shadow_card/solid_shadow_card.dart';
import 'package:flutter/material.dart';

class AccentSolidShadowCard extends SolidShadowCard {
  AccentSolidShadowCard({
    super.key,
    super.backgroundHeight,
    super.width,
    Widget? child,
  }) : super(
          backgroundDecoration: _backgroundDecoration,
          shadowColor: _shadowColor,
          child: child,
        );

  static final BoxDecoration _backgroundDecoration = BoxDecoration(
    gradient: _gradient,
    border: Border.all(
      color: const Color.fromRGBO(229, 140, 57, 1),
      width: 2,
    ),
  );

  static const LinearGradient _gradient = LinearGradient(
    colors: [
      Color.fromRGBO(253, 208, 77, 1),
      Color.fromRGBO(255, 156, 21, 1),
    ],
  );

  static const Color _shadowColor = Color.fromRGBO(151, 77, 10, 1);
}

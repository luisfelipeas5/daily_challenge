import 'package:daily_challenge/shared/widgets/solid_shadow_card/solid_shadow_card.dart';
import 'package:flutter/material.dart';

class DialogContainerCard extends SolidShadowCard {
  const DialogContainerCard({
    super.key,
    super.width,
    super.child,
  }) : super(
          backgroundDecoration: _backgroundDecoration,
          shadowColor: _shadowColor,
        );

  static const BoxDecoration _backgroundDecoration = BoxDecoration(
    color: Color.fromRGBO(255, 255, 255, 1),
  );

  static const Color _shadowColor = Color.fromRGBO(173, 173, 173, 1);
}

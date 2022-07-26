import 'package:daily_challenge/shared/widgets/solid_shadow_card/accent_solid_shadow_card.dart';
import 'package:flutter/material.dart';

enum TextCardButtonSize {
  medium,
  small,
}

class TextCardButton extends StatelessWidget {
  final String text;
  final double? minWidth;
  final TextCardButtonSize size;
  final VoidCallback? onTap;

  const TextCardButton({
    super.key,
    required this.text,
    this.size = TextCardButtonSize.medium,
    this.minWidth,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AccentSolidShadowCard(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: BoxConstraints(
          minWidth: minWidth ?? 0,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: _getTextStyle(context),
        ),
      ),
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    switch (size) {
      case TextCardButtonSize.medium:
        return textTheme.bodyLarge;
      case TextCardButtonSize.small:
        return textTheme.bodyMedium;
    }
  }
}

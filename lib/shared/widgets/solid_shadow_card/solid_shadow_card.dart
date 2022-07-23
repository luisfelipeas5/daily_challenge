import 'package:flutter/material.dart';

class SolidShadowCard extends StatelessWidget {
  static const double _shadowHeight = 6;

  static final BorderRadius _borderRadius = BorderRadius.circular(20);

  final BoxDecoration backgroundDecoration;
  final Color shadowColor;
  final double? width;
  final double? backgroundHeight;
  final Widget? child;

  const SolidShadowCard({
    super.key,
    required this.backgroundDecoration,
    required this.shadowColor,
    this.width,
    this.backgroundHeight,
    this.child,
  });

  static double? getHeight(double? backgroundHeight) {
    if (backgroundHeight == null) return null;
    return backgroundHeight + _shadowHeight;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: Container(
        color: shadowColor,
        width: width,
        child: Column(
          children: [
            _buildBackground(
              _buildChild(),
            ),
            const SizedBox(height: _shadowHeight),
          ],
        ),
      ),
    );
  }

  Widget _buildChild() {
    return Center(
      child: child ?? Container(),
    );
  }

  Widget _buildBackground(Widget backgroundChild) {
    return ClipRRect(
      borderRadius: _borderRadius,
      child: Container(
        height: backgroundHeight,
        decoration: backgroundDecoration,
        child: backgroundChild,
      ),
    );
  }
}

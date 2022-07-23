import 'package:flutter/material.dart';

class SolidShadowCard extends StatefulWidget {
  static const double _shadowHeight = 6;

  static final BorderRadius _borderRadius = BorderRadius.circular(20);

  final BoxDecoration backgroundDecoration;
  final Color shadowColor;
  final double? width;
  final double? backgroundHeight;
  final VoidCallback? onTap;
  final Widget? child;

  const SolidShadowCard({
    super.key,
    required this.backgroundDecoration,
    required this.shadowColor,
    this.width,
    this.backgroundHeight,
    this.onTap,
    this.child,
  });

  static double? getHeight(double? backgroundHeight) {
    if (backgroundHeight == null) return null;
    return backgroundHeight + _shadowHeight;
  }

  @override
  State<SolidShadowCard> createState() => _SolidShadowCardState();
}

class _SolidShadowCardState extends State<SolidShadowCard> {
  bool _tappedDown = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: SolidShadowCard._borderRadius,
      child: Container(
        color: widget.shadowColor,
        width: widget.width,
        child: Column(
          children: [
            _buildBackground(
              _buildChild(),
            ),
            _buildFakeShadow(),
          ],
        ),
      ),
    );
  }

  Widget _buildFakeShadow() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: _tappedDown
          ? SolidShadowCard._shadowHeight * 1.5
          : SolidShadowCard._shadowHeight,
    );
  }

  Widget _buildChild() {
    return Center(
      child: widget.child ?? Container(),
    );
  }

  Widget _buildBackground(Widget backgroundChild) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _setTappedDown(true),
      onTapUp: (_) => _setTappedDown(false),
      onTapCancel: () => _setTappedDown(false),
      child: ClipRRect(
        borderRadius: SolidShadowCard._borderRadius,
        child: Container(
          height: widget.backgroundHeight,
          decoration: widget.backgroundDecoration,
          child: backgroundChild,
        ),
      ),
    );
  }

  void _setTappedDown(bool value) {
    if (widget.onTap == null) return;
    setState(() {
      _tappedDown = value;
    });
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class Rotate extends StatefulWidget {
  final Duration animationDuration;
  final double centerX;
  final double centerY;
  final bool repeat;
  final Widget child;

  const Rotate({
    super.key,
    required this.animationDuration,
    required this.centerX,
    required this.centerY,
    this.repeat = false,
    required this.child,
  });

  @override
  State<Rotate> createState() => _RotateState();
}

class _RotateState extends State<Rotate> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween<double>(begin: 0.0, end: 6.0 * pi)
        .chain(CurveTween(curve: Curves.easeOutQuart))
        .animate(_controller);
    if (widget.repeat) {
      _controller.repeat();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform(
          transform: _getTransform(),
          origin: Offset(widget.centerX, widget.centerY),
          child: child,
        );
      },
      child: widget.child,
    );
  }

  Matrix4 _getTransform() => Matrix4.rotationY(_animation.value);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

import 'dart:math' as math;

import 'package:daily_challenge/shared/widgets/coin/sensor_coin.dart';
import 'package:flutter/material.dart';

const _animationDuration = Duration(seconds: 2);

class AnimatedRotationSensorCoin extends StatefulWidget {
  final double size;

  const AnimatedRotationSensorCoin({
    super.key,
    required this.size,
  });

  @override
  State<AnimatedRotationSensorCoin> createState() =>
      _AnimatedRotationSensorCoinState();
}

class _AnimatedRotationSensorCoinState extends State<AnimatedRotationSensorCoin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _animation = Tween<double>(begin: 0.0, end: 6.0 * math.pi)
        .chain(CurveTween(curve: Curves.easeOutQuart))
        .animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform(
          transform: _getTransform(),
          origin: Offset(
            widget.size / 2,
            widget.size / 2,
          ),
          child: child,
        );
      },
      child: SensorCoin(
        size: widget.size,
      ),
    );
  }

  Matrix4 _getTransform() => Matrix4.rotationY(_animation.value);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

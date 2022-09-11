import 'dart:math';

import 'package:flutter/material.dart';

class Shake extends StatefulWidget {
  final int shakeCount;
  final int shakeOffset;
  final Duration animationDuration;
  final Duration animationDelay;
  final bool shaking;
  final Widget child;

  const Shake({
    super.key,
    required this.shakeCount,
    required this.shakeOffset,
    required this.animationDelay,
    required this.animationDuration,
    this.shaking = true,
    required this.child,
  });

  @override
  State<Shake> createState() => _ShakeState();
}

class _ShakeState extends State<Shake> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _halfDuration,
    );
    _animation = Tween<double>(begin: 0.0, end: 1)
        .chain(CurveTween(curve: _curve))
        .animate(_controller);
    _animation.addStatusListener(_repeatAfterCompleted);
    _fowardAfterDelayIfShaking();
  }

  @override
  void didUpdateWidget(covariant Shake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.shaking) {
      _fowardAfterDelayIfShaking();
    } else {
      _controller.stop();
    }
  }

  Duration get _halfDuration => Duration(
        milliseconds: widget.animationDuration.inMilliseconds ~/ 2,
      );

  Curve get _curve => ShakeCurve(count: widget.shakeCount ~/ 2);

  void _repeatAfterCompleted(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _fowardAfterDelayIfShaking();
    }
  }

  Future<void> _fowardAfterDelayIfShaking() async {
    await Future.delayed(widget.animationDelay);
    if (!widget.shaking || !mounted) return;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            _animation.value * widget.shakeOffset,
            0,
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ShakeCurve extends Curve {
  const ShakeCurve({
    this.count = 3,
  });

  final int count;

  @override
  double transformInternal(double t) {
    return sin(count.toDouble() * 2 * pi * t);
  }
}

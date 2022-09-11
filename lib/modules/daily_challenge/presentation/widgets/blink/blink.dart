import 'package:flutter/material.dart';

class Blink extends StatefulWidget {
  final Widget child;
  final bool blinking;
  final Duration animationDuration;

  const Blink({
    super.key,
    required this.child,
    required this.animationDuration,
    this.blinking = true,
  });

  @override
  State<Blink> createState() => _BlinkState();
}

class _BlinkState extends State<Blink> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: _halfDuration,
    );
    _animation = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.decelerate))
        .animate(_controller);

    _animation.addStatusListener(_repeatAfterCompleted);
    _fowardIfBlinking();
  }

  Duration get _halfDuration => Duration(
        milliseconds: widget.animationDuration.inMilliseconds ~/ 2,
      );

  void _repeatAfterCompleted(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _reverseWithDelay();
    } else if (status == AnimationStatus.dismissed) {
      _fowardIfBlinking();
    }
  }

  void _reverseWithDelay() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    _controller.reverse();
  }

  Future<void> _fowardIfBlinking() async {
    if (!widget.blinking || !mounted) return;
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant Blink oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.blinking) {
      _fowardIfBlinking();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: widget.blinking ? _opacityByAnimation : 1,
          child: child,
        );
      },
      child: widget.child,
    );
  }

  double get _opacityByAnimation {
    return _animation.value;
  }
}

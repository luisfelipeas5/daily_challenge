import 'package:flutter/material.dart';

const _animationEnd = 2.0;

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
      duration: widget.animationDuration,
    );
    _animation =
        Tween<double>(begin: 0, end: _animationEnd).animate(_controller);

    if (widget.blinking) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant Blink oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.blinking) {
      _controller.repeat();
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
    final value = _animation.value;
    const middle = _animationEnd / 2;
    if (value <= middle) {
      return (value * 2) / _animationEnd;
    }
    return (_animationEnd - (value - middle)) / _animationEnd;
  }
}

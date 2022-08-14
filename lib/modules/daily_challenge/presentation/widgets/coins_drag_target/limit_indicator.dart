import 'package:flutter/material.dart';

const _animationEnd = 2.0;
const _animationDuration = Duration(seconds: 1, milliseconds: 500);

class LimitIndicator extends StatefulWidget {
  const LimitIndicator({
    super.key,
  });

  @override
  State<LimitIndicator> createState() => _LimitIndicatorState();
}

class _LimitIndicatorState extends State<LimitIndicator>
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
    _animation =
        Tween<double>(begin: 0, end: _animationEnd).animate(_controller);
    _controller.repeat();
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
          opacity: _opacity,
          child: child,
        );
      },
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 100,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 4);
        },
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            width: 8,
          );
        },
      ),
    );
  }

  double get _opacity {
    final value = _animation.value;
    const middle = _animationEnd / 2;
    if (value <= middle) {
      return (value * 2) / _animationEnd;
    }
    return (_animationEnd - (value - middle)) / _animationEnd;
  }
}

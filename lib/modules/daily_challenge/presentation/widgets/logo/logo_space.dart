import 'dart:math';

import 'package:flutter/material.dart';

const _animationDuration = Duration(milliseconds: 750);
const _animationDelay = Duration(milliseconds: 1000);

class LogoSpace extends StatefulWidget {
  const LogoSpace({
    super.key,
  });

  @override
  State<LogoSpace> createState() => _LogoSpaceState();
}

class _LogoSpaceState extends State<LogoSpace> {
  double _imageScale = 0;

  @override
  void initState() {
    super.initState();
    _scheduleEnterAnimation();
  }

  Future<void> _scheduleEnterAnimation() async {
    await Future.delayed(_animationDelay);
    setState(() {
      _imageScale = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onDoubleTap: _onDoubleTap,
          onLongPress: _onLongPress,
          child: Logo(
            scale: _imageScale,
          ),
        ),
      ],
    );
  }

  void _onDoubleTap() {
    setState(() {
      _imageScale = max(_imageScale * 0.8, 0.3);
    });
  }

  void _onLongPress() {
    setState(() {
      _imageScale = min(_imageScale * 1.2, 1);
    });
  }
}

class Logo extends StatelessWidget {
  final double scale;

  const Logo({
    super.key,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(45),
      child: AnimatedScale(
        duration: _animationDuration,
        curve: Curves.elasticInOut,
        scale: scale,
        child: Image.asset(
          "resources/images/logo.png",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

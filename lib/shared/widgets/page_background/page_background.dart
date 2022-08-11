import 'package:flutter/material.dart';

const _animationDuration = Duration(seconds: 1);
const _animationDelay = Duration.zero;

class PageBackground extends StatefulWidget {
  final Widget? child;

  const PageBackground({
    super.key,
    this.child,
  });

  @override
  State<PageBackground> createState() => _PageBackgroundState();
}

class _PageBackgroundState extends State<PageBackground> {
  bool _finalAnimationState = false;

  @override
  void initState() {
    super.initState();
    _scheduleEnterAnimation();
  }

  Future<void> _scheduleEnterAnimation() async {
    await Future.delayed(_animationDelay);
    setState(() {
      _finalAnimationState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getDecoration(),
      child: Stack(
        children: [
          _buildStar(),
          _buildChild(),
        ],
      ),
    );
  }

  BoxDecoration _getDecoration() {
    return const BoxDecoration(
      gradient: RadialGradient(
        colors: [
          Color.fromRGBO(116, 213, 255, 1),
          Color.fromRGBO(0, 71, 255, 1),
        ],
      ),
    );
  }

  Widget _buildChild() => widget.child ?? Container();

  Widget _buildStar() {
    return AnimatedOpacity(
      duration: _animationDuration,
      opacity: _finalAnimationState ? 1 : 0,
      child: AnimatedRotation(
        turns: _finalAnimationState ? 0 : 0.5,
        duration: _animationDuration,
        curve: Curves.decelerate,
        child: Center(
          child: Image.asset(
            "resources/images/star.png",
          ),
        ),
      ),
    );
  }
}

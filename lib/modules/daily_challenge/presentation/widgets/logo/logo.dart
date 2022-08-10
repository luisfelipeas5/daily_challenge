import 'package:flutter/material.dart';

const _animationDuration = Duration(milliseconds: 500);
const _animationDelay = Duration(milliseconds: 700);

class Logo extends StatefulWidget {
  const Logo({
    super.key,
  });

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  bool _showImage = false;

  @override
  void initState() {
    super.initState();
    _scheduleEnterAnimation();
  }

  Future<void> _scheduleEnterAnimation() async {
    await Future.delayed(_animationDelay);
    setState(() {
      _showImage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(45),
          child: AnimatedScale(
            duration: _animationDuration,
            scale: _showImage ? 1 : 0,
            child: Image.asset(
              "resources/images/logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}

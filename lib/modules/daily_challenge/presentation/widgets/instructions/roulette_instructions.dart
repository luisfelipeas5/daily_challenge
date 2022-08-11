import 'package:flutter/material.dart';

const _animationDuration = Duration(milliseconds: 500);
const _animationDelay = Duration(milliseconds: 700);

class RouletteInstructions extends StatefulWidget {
  const RouletteInstructions({
    super.key,
  });

  @override
  State<RouletteInstructions> createState() => _RouletteInstructionsState();
}

class _RouletteInstructionsState extends State<RouletteInstructions> {
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    _scheduleEnterAnimation();
  }

  Future<void> _scheduleEnterAnimation() async {
    await Future.delayed(_animationDelay);
    setState(() {
      _showText = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: _animationDuration,
      opacity: _showText ? 1 : 0,
      child: Column(
        children: [
          Text(
            "Quer tentar a sorte?",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            "Rode o desafio e ganhe Bits",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
